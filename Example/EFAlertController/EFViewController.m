//
//  EFViewController.m
//  EFAlertController
//
//  Created by EyreFree on 04/11/2017.
//  Copyright (c) 2017 EyreFree. All rights reserved.
//

#import "EFViewController.h"
#import "EFAlertController.h"

@interface EFViewController ()

@end

@implementation EFViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addControl];
}

- (void)addControl {
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:@"Test" forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, 200, 60);
    button1.center = self.view.center;
    [button1 addTarget:self action:@selector(testClicked1) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button1];

    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:@"Test" forState:UIControlStateNormal];
    button2.frame = CGRectMake(button1.frame.origin.x, button1.frame.origin.y + button1.frame.size.height + 100, 200, 60);
    [button2 addTarget:self action:@selector(testClicked2) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button2];
}

- (void)testClicked1 {
    EFAlertController *alert = [[EFAlertController alloc] init];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   NSLog(@"");
                                               }];
    UIAlertAction *other = [UIAlertAction actionWithTitle:@"other"
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      NSLog(@"");
                                                  }];
    [alert show:self
          title:@"Test Title"
        message:@"TestMessageTestTestMessageTestTestMessageTestTestMessageTestTestMessageTestTestMessageTest"
         action:@[cancel, ok, other]
     ];
}

- (void)testClicked2 {
    EFAlertController *alert = [[EFAlertController alloc] init];

    [alert setTitleFont:[UIFont systemFontOfSize:20]];
    [alert setTitleColor:[UIColor redColor]];
    [alert setMessageFont:[UIFont systemFontOfSize:18]];
    [alert setMessageColor:[UIColor blueColor]];
    [alert setActionColors:@[UIColor.blackColor, UIColor.grayColor, UIColor.orangeColor]];
    [alert setActionFonts:@[[UIFont systemFontOfSize:15], [UIFont systemFontOfSize:20], [UIFont systemFontOfSize:25]]];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   NSLog(@"");
                                               }];
    UIAlertAction *other = [UIAlertAction actionWithTitle:@"other"
                                                 style:UIAlertActionStyleDestructive
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   NSLog(@"");
                                               }];
    [alert show:self
          title:@"Test Title"
        message:@"TestMessageTestTestMessageTestTestMessageTestTestMessageTestTestMessageTestTestMessageTest"
         action:@[cancel, ok, other]
     ];
}

@end
