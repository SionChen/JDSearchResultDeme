//
//  UIColor+Hex.m
//
//  Created by kiefer on 14-4-3.
//  Copyright (c) 2014年 kiefer. All rights reserved.
//  

#import "UIColor+Hex.h"


@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    return [UIColor colorWithHexString:hexString alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha {
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString uppercaseString];
    if (!hexString || ![hexString length]) {
        return [UIColor clearColor];
    }
    if ([hexString hasPrefix:@"0X"] || [hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    unsigned int hexValue = 0;
    [[NSScanner scannerWithString:hexString] scanHexInt:&hexValue];
    return [self colorWithHex:hexValue alpha:alpha];
}

+ (UIColor *)colorWithHex:(long)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)colorWithHex:(long)hexValue alpha:(float)alpha {
    CGFloat red   = ((float)((hexValue & 0xFF0000) >> 16))/255.0;
    CGFloat green = ((float)((hexValue & 0xFF00) >> 8))/255.0;
    CGFloat blue  = ((float)(hexValue  & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
+ (UIImage *)imageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, screenWidth, screenHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}

@end
