//
//  UIColor+Hex.h
//
//  Created by kiefer on 14-4-3.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//  

#import <UIKit/UIKit.h>

#define screenWidth      [UIScreen mainScreen].bounds.size.width
#define screenHeight     [UIScreen mainScreen].bounds.size.height
#define navBarWidth       self.navigationController.navigationBar.bounds.size.width
#define navBarHeight      self.navigationController.navigationBar.bounds.size.height
#define statusBarHeight  [UIApplication sharedApplication].statusBarFrame.size.height
#define tabBarHeight     self.tabBarController.tabBar.bounds.size.height
@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)hexString;
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha;
+ (UIColor *)colorWithHex:(long)hexValue;
+ (UIColor *)colorWithHex:(long)hexValue alpha:(float)alpha;
+ (UIImage *)imageFromColor:(UIColor *)color;//颜色生成图片
@end
