//
//  ViewController.m
//  JDSearchResult
//
//  Created by 超级腕电商 on 2017/11/27.
//  Copyright © 2017年 超级腕电商. All rights reserved.
//

#pragma mark ---VC
#import "ViewController.h"
#pragma mark ---View
#import "SearchNavigationBar.h"
#import "GoodsSortTabBar.h"
#pragma mark ---Utils
#import "UIView+Size.h"
#import "UIColor+Hex.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,SearchNavigationBarDelegate,HKTabBarDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) SearchNavigationBar *searchBar;//搜索
@property (nonatomic,strong) GoodsSortTabBar *mTabBar;//筛选
@property (nonatomic,assign) CGFloat lastOffset;//停止滑动时的偏移量

@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.lastOffset = 0.0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}
- (void)setupUI {
    CGFloat viewWidth  = screenWidth;
    CGFloat viewHeight = screenHeight - statusBarHeight;
    if (!self.hidesBottomBarWhenPushed) {
        viewHeight -=tabBarHeight;
    }
    self.searchBar.frame = CGRectMake(0, 20, screenWidth, 44+44);
    [self.view addSubview:self.searchBar];
    
    self.mTabBar.frame = CGRectMake(0, self.searchBar.bottom, viewWidth, 40);
    self.mTabBar.titles = @[@"品牌",@"推荐", @"价格", @"销量"];
    self.mTabBar.selectedIndex = 0;
    [self.view addSubview:self.mTabBar];
    
    self.tableView.frame = CGRectMake(0, self.mTabBar.bottom, viewWidth, viewHeight - self.mTabBar.height);
    [self.view addSubview:self.tableView];
    
}
#pragma mark SearchNavigationBarDelegate
-(void)didSelectItemWithIsArticle:(BOOL)isArticle
{
    NSLog(@"didSelectItemWithIsArticle");
    
}
#pragma mark - HKTabBarDelegate
// 排序规则，S=综合 P=价格顺序 D=价格倒序 A=销量
- (void)tabBar:(HKTabBar *)tabBar didSelectItem:(HKTabBarItem *)tabBarItem {
    NSLog(@"didSelectItem");
    SortTabBarItem *priceTabBarItem = (SortTabBarItem*)[tabBar tabBarItemWithIndex:2];
    switch (tabBar.selectedIndex) {
        case 0: {
            priceTabBarItem.sortType = 0;
        }
            break;
        case 1: {
            priceTabBarItem.sortType = 0;
        }
            break;
        case 2: {
            if (priceTabBarItem.sortType == SortTypePriceAscending) {
                priceTabBarItem.sortType = SortTypePriceDescending;
            } else if (priceTabBarItem.sortType == SortTypePriceDescending) {
                priceTabBarItem.sortType = SortTypePriceAscending;
            } else {
                priceTabBarItem.sortType = SortTypePriceAscending;
            }
        }
            break;
        case 3: {
            priceTabBarItem.sortType = 0;
        }
            break;
        default:
            break;
    }
    [self.searchBar resignFirstResponder];
    [self.tableView setContentOffset:CGPointMake(0, 0)];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y != self.lastOffset) {
        BOOL isUp = scrollView.contentOffset.y > self.lastOffset;
        [self hideTopViewWithIsUp:isUp];
    }
}

/**
 将要开始滑动记录偏移量

 @param scrollView -
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastOffset = scrollView.contentOffset.y>0?(scrollView.contentOffset.y>(scrollView.contentSize.height-scrollView.height)?(scrollView.contentSize.height-scrollView.height):scrollView.contentOffset.y):0;
}

/**
 隐藏顶部视图

 @param isUp 是否是上滑
 */
-(void)hideTopViewWithIsUp:(BOOL)isUp
{
    if (self.searchBar.hidden==isUp) {return;}
    if (isUp) {//向上滑隐藏
        self.searchBar.sortBar.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            self.searchBar.height = 0;
            self.searchBar.top = 0;
            self.mTabBar.top = statusBarHeight;
            self.tableView.top = statusBarHeight+self.mTabBar.height;
        } completion:^(BOOL finished) {
            self.searchBar.hidden = YES;
        }];
    }else//向下滑出现
    {
        self.searchBar.hidden = NO;
        self.searchBar.sortBar.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.searchBar.height = 44+44;
            self.searchBar.top = statusBarHeight;
            self.mTabBar.top = statusBarHeight+44+44;
            self.tableView.top = statusBarHeight+44+44+self.mTabBar.height;
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark ---G
-(UITableView*)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor whiteColor];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = false;
        _tableView.showsVerticalScrollIndicator = true;
        _tableView.delaysContentTouches = false;
        _tableView.scrollsToTop = true;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}
-(SearchNavigationBar*)searchBar{
    if(!_searchBar){
        _searchBar = [[SearchNavigationBar alloc] init];
        _searchBar.layer.masksToBounds = YES;
        _searchBar.delegate = self;
    }
    return _searchBar;
}
-(GoodsSortTabBar*)mTabBar{
    if(!_mTabBar){
        _mTabBar = [[GoodsSortTabBar alloc] init];
        //mTabBar.backgroundColor = color_topBar;
        //_mTabBar.titles = @[@"品牌",@"推荐", @"价格", @"销量"];
        _mTabBar.selectedIndex = 0;
        _mTabBar.delegate = self;
        _mTabBar.selectedLine.hidden = YES;
    }
    return _mTabBar;
}

@end
