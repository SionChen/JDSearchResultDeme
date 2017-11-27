//
//  SearchNavigationBar.m
//  Project
//
//  Created by 超级腕电商 on 2017/8/29.
//  Copyright © 2017年 super. All rights reserved.
//

#import "SearchNavigationBar.h"
#import "UIView+Size.h"
#import "UIColor+Hex.h"

#define CALL_DELEGATE(_delegate, _selector) \
do { \
id _theDelegate = _delegate; \
if(_theDelegate != nil && [_theDelegate respondsToSelector:_selector]) { \
[_theDelegate performSelector:_selector]; \
} \
} while(0);
@implementation SearchNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        //[self addSubview:self.collectionView];
        [self addSubview:self.searchBar];
        [self addSubview:self.sortBar];
        [self addSubview:self.backButton];
        [self.layer addSublayer:self.separateShapeLayer];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backButton.frame = CGRectMake(10, 44/2-30/2, 30, 30);
    self.searchBar.frame = CGRectMake(self.backButton.right+5, self.backButton.top, self.width-15-self.backButton.right-5, 30);
    self.sortBar.frame = CGRectMake(0, self.searchBar.bottom+7, self.width, self.height-self.searchBar.bottom-7);
    self.separateShapeLayer.path = [self separatePath].CGPath;
}
#pragma mark path
-(UIBezierPath *)separatePath
{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 44)];
    
    [path addLineToPoint:CGPointMake(self.width, 44)];
    return path;
}
#pragma mark actions
-(void)backButtonAction
{
    CALL_DELEGATE(self.delegate, @selector(_handleViewBack));
}
#pragma mark - HKTabBarDelegate
// 排序规则，S=综合 P=价格顺序 D=价格倒序 A=销量
- (void)tabBar:(HKTabBar *)tabBar didSelectItem:(HKTabBarItem *)tabBarItem {
    if ([self.delegate respondsToSelector:@selector(didSelectItemWithIsArticle:)]) {
        [self.delegate didSelectItemWithIsArticle:tabBar.selectedIndex];
    }
}
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CALL_DELEGATE(self.delegate, @selector(pushSearchViewController));
    return NO;
}
#pragma mark G
-(CustomSearchBar*)searchBar{
    if(!_searchBar){
        //_searchBar
        _searchBar = [[CustomSearchBar alloc] init];
        _searchBar.backgroundColor = [UIColor clearColor];
        _searchBar.placeholder = @"请输入关键字";
        _searchBar.delegate = self;

    }
    return _searchBar;
}
-(GoodsSortTabBar*)sortBar{
    if(!_sortBar){
        _sortBar = [[GoodsSortTabBar alloc] init];
        //mTabBar.backgroundColor = color_topBar;
        _sortBar.titles = @[@"品牌商品",@"文章动态"];
        _sortBar.selectedIndex = 0;
        _sortBar.delegate = self;
    }
    return _sortBar;
}
-(UIButton*)backButton{
    if(!_backButton){
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:[UIImage imageNamed:@"navItemBack"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
-(CAShapeLayer*)separateShapeLayer{
    if(!_separateShapeLayer){
        _separateShapeLayer  = [CAShapeLayer layer];
        _separateShapeLayer.strokeColor = [UIColor colorWithHex:0xe0e0e0].CGColor;
        _separateShapeLayer.fillColor = [UIColor clearColor].CGColor;
        _separateShapeLayer.lineWidth = 0.5;
    }
    return _separateShapeLayer;
}
@end
