//
//  EFAlertController.h
//  EFAlertController
//
//  Created by EyreFree on 2017/4/4.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFAlertController : UIAlertController

/// Recommand to less than 30
- (void)setTitleFont:(UIFont*)font;
- (void)setTitleColor:(UIColor*)color;

/// Recommand to less than 24
- (void)setMessageFont:(UIFont*)font;
- (void)setMessageColor:(UIColor*)color;

/// Recommand to less than 50
/// UIAlertActionStyleDefault = 0,
/// UIAlertActionStyleCancel = 1,
/// UIAlertActionStyleDestructive = 2
- (void)setActionFonts:(NSArray<UIFont*> *)fonts;
- (void)setActionColors:(NSArray<UIColor*> *)colors;

- (void)show:(UIViewController *)target
       title:(NSString *)title
     message:(NSString *)message
      action:(NSArray<UIAlertAction *> *)actions;

@end
