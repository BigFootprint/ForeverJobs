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

@end

@implementation NewsViewController
@synthesize leftItem;
@synthesize centerView;
@synthesize hyiHorArrangeScrollView;
@synthesize categoryArr;

-(void)viewDidLoad {
    [super viewDidLoad];
    // 数据
    categoryArr = [[NewsDataSource sharedInstance] getNewsCategory];
    
    hyiHorArrangeScrollView = [[HyiHorArrangeScrollView alloc] init];
    hyiHorArrangeScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 40);
    [hyiHorArrangeScrollView setBackgroundColor:[UIColor blueColor]];
    hyiHorArrangeScrollView.delegate = self;
    [self.view addSubview:hyiHorArrangeScrollView];
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

-(UIView *)getView:(int)index {
    NewsCategory *nc = [categoryArr objectAtIndex:index];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [label setText:nc.categoryName];
    [label setTextColor:HYI_RED];
    [label sizeToFit];
    [label setBackgroundColor:[UIColor greenColor]];
    return label;
}

-(void)selectView:(UIView *)selectedView {
    
}
@end
