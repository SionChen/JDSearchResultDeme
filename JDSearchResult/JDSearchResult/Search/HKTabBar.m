//
//  HKTabBar.m
//  superwan
//
//  Created by superwan on 15/5/28.
//  Copyright (c) 2015年 Neo Yang. All rights reserved.
//

#import "HKTabBar.h"

@implementation HKTabBar

- (HKTabBarItem *)createTabBarItem
{
    HKTabBarItem *tabBarItem = [[HKTabBarItem alloc] init];
    tabBarItem.backgroundColor = [UIColor clearColor];
    return tabBarItem;
}

- (void)setupTabBarItemCaches
{
    if (![self.titles count]) {
        [tabBarItemCaches makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [tabBarItemCaches removeAllObjects];
        return;
    }
    
    if (tabBarItemCaches == nil) {
        tabBarItemCaches = [[NSMutableArray alloc] init];
    }
    if ([tabBarItemCaches count]) {
        [tabBarItemCaches makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [tabBarItemCaches removeAllObjects];
    }
    for (int i = 0; i < [self.titles count]; i++) {
        HKTabBarItem *tabBarItem = [self createTabBarItem];
        tabBarItem.tag = i;
        [tabBarItem addTarget:self action:@selector(actionTabBarItem:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:tabBarItem];
        [tabBarItemCaches addObject:tabBarItem];
    }
}

- (void)actionTabBarItem:(HKTabBarItem *)tabBarItem
{
    [self setSelectedIndex:tabBarItem.tag];
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [self.delegate tabBar:self didSelectItem:tabBarItem];
    }
}

- (void)setTitles:(NSArray *)titles
{
    if (_titles != titles) {
        _titles = titles;
        
        [self setupTabBarItemCaches];
        [self setSelectedIndex:0];
        [self setNeedsLayout];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if (selectedIndex < [self numberOfItems]) {
        for (int i = 0; i < [self numberOfItems]; i++) {
            HKTabBarItem *tabBarItem = tabBarItemCaches[i];
            tabBarItem.selected = (i == selectedIndex);
        }
    }
    [self setNeedsLayout];
}

- (NSUInteger)numberOfItems
{
    return [tabBarItemCaches count];
}

- (HKTabBarItem *)selectedTabBarItem
{
    if (_selectedIndex < [self numberOfItems]) {
        return tabBarItemCaches[_selectedIndex];
    }
    return nil;
}

- (HKTabBarItem *)tabBarItemWithIndex:(int)index
{
    if (index >= 0 && index < [self numberOfItems]) {
        return tabBarItemCaches[index];
    }
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat itemWidth  = self.bounds.size.width;
    CGFloat itemHeight = self.bounds.size.height;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    if ([self numberOfItems] > 0) {
        itemWidth = self.bounds.size.width/[self numberOfItems];
        for (int i = 0; i < [self numberOfItems]; i++) {
            HKTabBarItem *tabBarItem = tabBarItemCaches[i];
            tabBarItem.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
            tabBarItem.title = self.titles[i];
            itemX = itemX + itemWidth;
        }
    }
}

@end
