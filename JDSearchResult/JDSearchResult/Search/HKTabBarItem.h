//
//  HKTabBarItem.h
//  superwan
//
//  Created by superwan on 15/5/28.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKTabBarItem : UIControl
{
    UILabel *titleLabel;
    BOOL _selected;
}

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) UIFont *font;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *titleColorSelected;
@property(nonatomic, getter=isSelected) BOOL selected;

@end
