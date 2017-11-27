//
//  GoodsSortTabBar.m
//  superwan
//
//  Created by kiefer on 15-3-23.
//  Copyright (c) 2015年 kiefer. All rights reserved.
//

#import "GoodsSortTabBar.h"
#import "UIView+Size.h"
#import "UIColor+Hex.h"

@implementation GoodsSortTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _selectedLine = [[UIView alloc] init];
        _selectedLine.backgroundColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:_selectedLine];
    }
    return self;
}

- (SortTabBarItem *)createTabBarItem {
    SortTabBarItem *tabBarItem = [[SortTabBarItem alloc] init];
    tabBarItem.backgroundColor = [UIColor clearColor];
    tabBarItem.font = [UIFont systemFontOfSize:14.0];
    tabBarItem.titleColor = [UIColor grayColor];
    tabBarItem.titleColorSelected = [UIColor redColor];
    return tabBarItem;
}

- (void)layoutSubviews {
    //CGFloat itemW = 80.0;
    CGFloat itemW = self.width/[self.titles count];
    CGFloat itemH = self.height;
    CGFloat itemX = 0;
    CGFloat itemY = self.height/2 - itemH/2;
    NSUInteger count = [self numberOfItems];
    if (count > 0) {
        CGFloat spacing = (self.width - itemW * count)/(count - 1);
        for (int i = 0; i < count; i++) {
            SortTabBarItem *tabBarItem = tabBarItemCaches[i];
            tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
            tabBarItem.title = self.titles[i];
            tabBarItem.isSortTypePrice = ([tabBarItem.title isEqualToString:@"价格"]) ? true : false;
            itemX = itemX + itemW + spacing;
        }
        SortTabBarItem *tabBarItem = (SortTabBarItem*)[self selectedTabBarItem];
        if (tabBarItem) {
            if (CGRectEqualToRect(_selectedLine.frame, CGRectZero)) {
                CGSize textSize = [tabBarItem.title sizeWithAttributes:@{NSFontAttributeName:tabBarItem.font}];
                _selectedLine.width = textSize.width + 4;
                _selectedLine.height = 2.0;
                _selectedLine.centerX = tabBarItem.centerX;
                _selectedLine.bottom = tabBarItem.height;
            }
            CGSize textSize = [tabBarItem.title sizeWithAttributes:@{NSFontAttributeName:tabBarItem.font}];
            _selectedLine.width = textSize.width + 4;
            _selectedLine.height = 2.0;
            _selectedLine.bottom = tabBarItem.height;
            
            [UIView animateWithDuration:0.25 animations:^{
                _selectedLine.centerX = tabBarItem.centerX;
            } completion:^(BOOL finished) {
                _selectedLine.centerX = tabBarItem.centerX;
            }];
        }
    }
}

- (void)drawRect:(CGRect)rect {
    CGFloat width  = rect.size.width;
    CGFloat height = rect.size.height;
    CGFloat borderWidth = 0.5;
    CGFloat halfLineWidth = borderWidth/2;
    UIColor *borderColor = [UIColor colorWithHex:0xe0e0e0];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(ctx, true);
    CGContextSetStrokeColorWithColor(ctx, borderColor.CGColor);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, borderWidth);
    
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, 0, height - halfLineWidth);
    CGContextAddLineToPoint(ctx, width, height - halfLineWidth);
    
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathStroke);
}

@end
