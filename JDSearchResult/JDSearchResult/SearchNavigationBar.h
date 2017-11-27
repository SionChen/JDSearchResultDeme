//
//  SearchNavigationBar.h
//  Project
//
//  Created by 超级腕电商 on 2017/8/29.
//  Copyright © 2017年 super. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSearchBar.h"
#import "GoodsSortTabBar.h"

@protocol SearchNavigationBarDelegate <NSObject>
@optional
- (void)_handleViewBack;
-(void)pushSearchViewController;
-(void)didSelectItemWithIsArticle:(BOOL)isArticle;

@end
@interface SearchNavigationBar : UIView<UITextFieldDelegate,HKTabBarDelegate>

@property(nonatomic, strong) CustomSearchBar *searchBar;
@property (nonatomic,strong) CAShapeLayer *separateShapeLayer;//分隔线
@property (nonatomic,strong) GoodsSortTabBar *sortBar;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,weak) id<SearchNavigationBarDelegate> delegate;

@end
