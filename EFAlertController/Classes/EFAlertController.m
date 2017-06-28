//
//  EFAlertController.m
//  EFAlertController
//
//  Created by EyreFree on 2017/4/4.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import "EFAlertController.h"

#define EFAlertControllerTitleLabelTag      2222
#define EFAlertControllerMessageLabelTag    2333
#define EFAlertControllerActionLabelTag     4555

@interface EFAlertController ()

@property (nonatomic, strong) UIColor *titleColorEF;
@property (nonatomic, strong) UIFont *titleFontEF;

@property (nonatomic, strong) UIColor *messageColorEF;
@property (nonatomic, strong) UIFont *messageFontEF;

@property (nonatomic, strong) NSArray<UIColor*> *actionColorsEF;
@property (nonatomic, strong) NSArray<UIFont*> *actionFontsEF;

@end

// EFAlertController
@implementation EFAlertController

- (void)setTitleColor:(UIColor*)color {
    _titleColorEF = color;
}

- (void)setTitleFont:(UIFont*)font {
    _titleFontEF = font;
}

- (void)setMessageColor:(UIColor*)color {
    _messageColorEF = color;
}

- (void)setMessageFont:(UIFont*)font {
    _messageFontEF = font;
}

- (void)setActionColors:(NSArray<UIColor*> *)colors {
    _actionColorsEF = colors;
}

- (void)setActionFonts:(NSArray<UIFont*> *)fonts {
    _actionFontsEF = fonts;
}

- (void)show:(UIViewController *)target title:(NSString *)title message:(NSString *)message action:(NSArray<UIAlertAction *> *)actions {
    // 构建一个普通的 EFAlertController 并弹起
    EFAlertController *alertController = [EFAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];

    [alertController setTitleColor:self.titleColorEF];
    [alertController setTitleFont:self.titleFontEF];
    [alertController setMessageColor:self.messageColorEF];
    [alertController setMessageFont:self.messageFontEF];
    [alertController setActionColors:self.actionColorsEF];
    [alertController setActionFonts:self.actionFontsEF];

    for (id action in actions) {
        UIAlertAction *alertAction = (UIAlertAction *)action;
        UIColor *color = [alertController getActionColorWith:alertAction.style];
        if (nil != color) {
            [alertAction setValue:color forKey:@"titleTextColor"];
        }
        [alertController addAction:alertAction];
    }
    
    [target presentViewController:alertController animated:YES completion:nil];
}

//观察者需要实现的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UILabel *actionLabel = (UILabel *)object;
    UIAlertActionStyle actionStyle = (UIAlertActionStyle)(actionLabel.tag - EFAlertControllerActionLabelTag);
    UIFont *font = [self getActionFontWith:actionStyle];
    if (nil != font) {
        UIFont *myActionLabelFont = font;
        UIFont *newFont = [change objectForKey:NSKeyValueChangeNewKey];
        if (newFont.pointSize != myActionLabelFont.pointSize || newFont.fontName != myActionLabelFont.fontName) {
            [actionLabel setFont:myActionLabelFont];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 查找 title 和 message 所在 UILabel
    // http://blog.csdn.net/tcm455090672/article/details/51512577
    UIView *subView1 = self.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    // 取 Title Label 改样式并做标记
    UILabel *title = subView5.subviews[0];
    if (self.titleColorEF != nil) {
        title.textColor = self.titleColorEF;
    }
    if (self.titleFontEF != nil) {
        title.font = self.titleFontEF;
    }
    title.tag = EFAlertControllerTitleLabelTag;
    // 取 Message Label 改样式并做标记
    UILabel *message = subView5.subviews[1];
    if (self.messageColorEF != nil) {
        message.textColor = self.messageColorEF;
    }
    if (self.messageFontEF != nil) {
        message.font = self.messageFontEF;
    }
    message.tag = EFAlertControllerMessageLabelTag;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 强制 AutoLayout 刷新 Message 尺寸
    UILabel *message = (UILabel *)[self getView:self.view with:EFAlertControllerMessageLabelTag];
    [message layoutIfNeeded];

    // 为 Action Label 修改字体
    NSArray *actionViews = [self getActionLabels:self.view];
    for (UILabel *actionlabel in actionViews) {
        UIAlertActionStyle actionStyle = [self getStyleWith:actionlabel.text];
        actionlabel.tag = EFAlertControllerActionLabelTag + actionStyle;
        UIFont *font = [self getActionFontWith:actionStyle];
        if (nil != font) {
            [actionlabel setFont:font];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // 为 Action Label 添加观察者
    NSArray *actionViews = [self getActionLabels:self.view];
    for (id actionView in actionViews) {
        [(UILabel *)actionView addObserver:self
                                forKeyPath:@"font"
                                   options:NSKeyValueObservingOptionNew
                                   context:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    // 为 Action Label 移除观察者
    NSArray *actionViews = [self getActionLabels:self.view];
    for (id actionView in actionViews) {
        [(UILabel *)actionView removeObserver:self forKeyPath:@"font"];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    UILabel *message = (UILabel *)[self getView:self.view with:EFAlertControllerMessageLabelTag];
    // NSLog(@"viewDidLayoutSubviews: %f", message.frame.size.height);
    // 如果正文是多行然后设置 Message 内容居左
    if (message.frame.size.height > 20) {
        message.textAlignment = NSTextAlignmentLeft;
    }
}

- (NSArray *)getLabels:(UIView *)view {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if ([view isKindOfClass:[UILabel class]] == YES) {
        [result addObject:view];
    }
    for (int index = 0; index < view.subviews.count; ++index) {
        NSArray *tempArray = [self getLabels:view.subviews[index]];
        if (0 < tempArray.count) {
            [result addObjectsFromArray:tempArray];
        }
    }
    return result;
}

- (NSArray *)getActionLabels:(UIView *)view {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *labels = [self getLabels:view];
    for (id label in labels) {
        UILabel *tempLabel = label;
        if (tempLabel.tag != EFAlertControllerMessageLabelTag && tempLabel.tag != EFAlertControllerTitleLabelTag) {
            [result addObject:tempLabel];
        }
    }
    return result;
}

- (UIView *)getView:(UIView *)view with:(int)tag {
    if (view.tag == tag) {
        return view;
    }
    for (int index = 0; index < view.subviews.count; ++index) {
        UIView *tempView = [self getView:view.subviews[index] with:tag];
        if (nil != tempView) {
            return tempView;
        }
    }
    return nil;
}

- (UIAlertActionStyle)getStyleWith:(NSString *)text {
    for (UIAlertAction *action in self.actions) {
        if ([action.title isEqualToString:text]) {
            return action.style;
        }
    }
    return UIAlertActionStyleDefault;
}

- (UIFont *)getActionFontWith:(UIAlertActionStyle)style {
    if (self.actionFontsEF == nil) {
        return nil;
    }
    if (self.actionFontsEF.count <= style) {
        return nil;
    }
    return self.actionFontsEF[style];
}

- (UIColor *)getActionColorWith:(UIAlertActionStyle)style {
    if (self.actionColorsEF == nil) {
        return nil;
    }
    if (self.actionColorsEF.count <= style) {
        return nil;
    }
    return self.actionColorsEF[style];
}

@end
