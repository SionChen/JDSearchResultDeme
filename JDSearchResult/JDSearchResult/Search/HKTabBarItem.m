//
//  HKTabBarItem.m
//  superwan
//
//  Created by superwan on 15/5/28.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import "HKTabBarItem.h"

@implementation HKTabBarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines =0;
        [self addSubview:titleLabel];
        
        _font = [UIFont systemFontOfSize:15.0];
        _titleColor = [UIColor blackColor];
        _titleColorSelected = [UIColor redColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        [self setNeedsLayout];
    }
}

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        [self setNeedsLayout];
    }
}

- (BOOL)isSelected
{
    return _selected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (![self isSelected]) {
        titleLabel.textColor = _titleColor;
    } else {
        titleLabel.textColor = _titleColorSelected;
    }
    titleLabel.text = _title;
    titleLabel.font = _font;
    titleLabel.frame = self.bounds;
}

@end
