//
//  HKTabBar.h
//  superwan
//
//  Created by superwan on 15/5/28.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKTabBarItem.h"

@protocol HKTabBarDelegate;
@interface HKTabBar : UIView {
    @package
    NSMutableArray *tabBarItemCaches;
    NSUInteger _selectedIndex;
    NSArray *_titles;
}

@property(nonatomic, assign) id<HKTabBarDelegate> delegate;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic) NSUInteger selectedIndex;

- (NSUInteger)numberOfItems;
- (HKTabBarItem *)selectedTabBarItem;
- (HKTabBarItem *)tabBarItemWithIndex:(int)index;

@end


@protocol HKTabBarDelegate <NSObject>
@optional
- (void)tabBar:(HKTabBar *)tabBar didSelectItem:(HKTabBarItem *)tabBarItem;
@end
