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
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Test" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 200, 60);
    button.center = self.view.center;
    [button addTarget:self action:@selector(testClicked) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

- (void)testClicked {
    [EFAlertController setTitleFont:[UIFont systemFontOfSize:32]];
    [EFAlertController setActionColors:@[UIColor.blackColor, UIColor.grayColor, UIColor.redColor]];
    [EFAlertController setActionFonts:@[[UIFont systemFontOfSize:12], [UIFont systemFontOfSize:24], [UIFont systemFontOfSize:48]]];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * _Nonnull action) {
                                                   NSLog(@"");
                                               }];
    [EFAlertController show:self title:@"Test Title" message:@"Test Message" action:@[cancel, ok]];
}

@end
