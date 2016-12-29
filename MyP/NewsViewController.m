//
//  NewsViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "NewsViewController.h"
#import "HyiHorArrangeScrollView.h"
#import "HyiHorArrangeScrollViewAdapter.h"
#import "Masonry.h"
#import "JobsConstants.h"
#import "NewsDataSource.h"
#import "Color.h"

@interface NewsViewController () <HyiHorArrangeScrollViewAdapter>
@property(nonatomic, strong) UIBarButtonItem *leftItem;
@property(nonatomic, strong) UIImageView *centerView;
@property(nonatomic, strong) HyiHorArrangeScrollView *hyiHorArrangeScrollView;
@property(nonatomic, strong) NSArray<NewsCategory *> *categoryArr;
@property(nonatomic, strong) UIFont *normalFont;
@property(nonatomic, strong) UIFont *selectFont;
@end

@implementation NewsViewController
@synthesize leftItem;
@synthesize centerView;
@synthesize hyiHorArrangeScrollView;
@synthesize categoryArr;
@synthesize normalFont;
@synthesize selectFont;

-(void)viewDidLoad {
    [super viewDidLoad];
    // 数据
    categoryArr = [[NewsDataSource sharedInstance] getNewsCategory];
    normalFont = [UIFont fontWithName:@"Arial" size:16];
    selectFont = [UIFont fontWithName:@"Arial" size:20];
    
    // View
    hyiHorArrangeScrollView = [[HyiHorArrangeScrollView alloc] init];
    hyiHorArrangeScrollView.hyiDataSource = self;
    
    // TODO-待整理
    // 64 像素偏移问题，UIScrollView 作为第一个元素加入到 self.view 的时候会产生偏移，
    // 下面文章有解决方案，但是不生效，日狗，添加一个 View 倒是可以解决
    // https://www.swiftmi.com/topic/329.html
    UIView *bugFixView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [bugFixView setBackgroundColor:[UIColor greenColor]];
    
    [self.view addSubview:bugFixView];
    [self.view addSubview:hyiHorArrangeScrollView];
}

-(void)viewDidAppear:(BOOL)animated {
    
}

-(void)initNavigationBar {
    // TODO-待解决
    // 此处有个Bug:
    // 现在的嵌套格式是 NavigationController 嵌套着一个 TabBarController，NewsViewController
    // 在初次加载的时候不会调用 viewWillAppear 方法。这个问题貌似一直有，后面解决
    [self initLeftButton];
    [self initCenterView];
}

- (void)initLeftButton {
    if(leftItem == nil) {
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [leftButton setImage:[UIImage imageNamed:@"share_platform_lofter"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(liveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
    
    // TODO-待整理
    // 这里一定要加上 tabBarController 才行，NaviController 只会去读这个 tabBarController 的
    // navigationItem 值
    self.tabBarController.navigationItem.leftBarButtonItem = leftItem;
}

-(void)initCenterView {
    if(centerView == nil){
        centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
        [centerView setImage:[UIImage imageNamed:@"navbar_netease"]];
    }
    
    self.tabBarController.navigationItem.titleView = centerView;
}

-(void)viewWillLayoutSubviews {
    [hyiHorArrangeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(STATUS_BAR_HEIGHT + NAVI_BAR_HEIGHT);
        make.left.mas_equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 40));
    }];
}

- (void)liveButtonClicked:(id)sender {
    [self.tabBarController setSelectedIndex:1];
}

#pragma HyiHorArrangeScrollViewAdapter
-(int)getCount {
    return (int)[categoryArr count];
}

-(UIView *)getView:(int)index withOffset:(int)offset {
    NewsCategory *nc = [categoryArr objectAtIndex:index];
    int fontSize = 16;
    CGSize textSize =[nc.categoryName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    int textActualWidth = textSize.width + 30;// 两边留白
    
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset, 0, textActualWidth, 40)];
    [categoryLabel setText:nc.categoryName];
    [categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [categoryLabel setTextColor:TEXT_DARK_GRAY];
    [categoryLabel setFont:normalFont];
    [categoryLabel setBackgroundColor:BG_MAIN];
    return categoryLabel;
}

-(void)switchSelectView:(UIView *)selectedView withIndex:(int)index withOldView:(UIView *)oldView withOldIndex:(int)oldIndex {
    if(selectedView != nil){
        UILabel *selectLabel = (UILabel *)selectedView;
        selectLabel.font = selectFont;
        selectLabel.textColor = HYI_RED;
    }
    
    if(oldView != nil){
        UILabel *oldLabel = (UILabel *)oldView;
        oldLabel.font = normalFont;
        oldLabel.textColor = TEXT_DARK_GRAY;
    }
}
@end
