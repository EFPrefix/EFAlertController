//
//  EFAlertController.h
//  EFAlertController
//
//  Created by EyreFree on 2017/4/4.
//  Copyright (c) 2015年 foxsofter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFAlertController : UIAlertController

+ (void)setTitleColor:(UIColor*)color;
+ (void)setTitleFont:(UIFont*)font;
+ (void)setMessageColor:(UIColor*)color;
+ (void)setMessageFont:(UIFont*)font;

// UIAlertActionStyleDefault = 0
// UIAlertActionStyleCancel = 1
// UIAlertActionStyleDestructive = 2
+ (void)setActionColors:(NSArray<UIColor*> *)colors;
+ (void)setActionFonts:(NSArray<UIFont*> *)fonts;

//  target: UIViewController
//   title: String
// message: String
// NSArray: [UIAlertAction]
+ (void)show:(UIViewController *)target title:(NSString *)title message:(NSString *)message action:(NSArray<UIAlertAction *> *)actions;

@end
