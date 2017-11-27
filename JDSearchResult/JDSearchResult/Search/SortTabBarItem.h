//
//  SortTabBarItem.h
//  superwan
//
//  Created by kiefer on 15/10/11.
//  Copyright (c) 2015年 super. All rights reserved.
//

#import "HKTabBarItem.h"

// 排序类型枚举
typedef NS_ENUM(NSInteger, SortType) {
    SortTypePriceAscending = 1, //价格升序
    SortTypePriceDescending = 2, //价格降序
};

@interface SortTabBarItem : HKTabBarItem {
    UIImageView *_imageView;
}

@property(nonatomic) BOOL isSortTypePrice;
@property(nonatomic) SortType sortType;

@end
