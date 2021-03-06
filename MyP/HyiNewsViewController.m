//
//  NewsViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNewsViewController.h"
#import "HyiHorArrangeScrollView.h"
#import "HyiHorArrangeScrollViewAdapter.h"
#import "HyiMultiPageScrollView.h"
#import "HyiMultiPageScrollViewDataSource.h"
#import "HyiMultiPageScrollViewDataDelegate.h"
#import "HyiNewsChannelDataSource.h"
#import "HyiNewsTableView.h"
#import "HyiNewsDataSource.h"
#import "HyiNewsDataMocker.h"
#import "HyiLiveView.h"
#import "HyiColor.h"
#import "JobsConstants.h"

#import "Masonry.h"

@interface HyiNewsViewController () <HyiHorArrangeScrollViewAdapter, HyiMultiPageScrollViewDataSource, HyiMultiPageScrollViewDataDelegate>
@property(nonatomic, strong) UIBarButtonItem *leftItem;
@property(nonatomic, strong) HyiLiveView *leftView;
@property(nonatomic, strong) UIImageView *centerView;
@property(nonatomic, strong) UIBarButtonItem *rightItem;
@property(nonatomic, strong) HyiHorArrangeScrollView *hyiHorArrangeScrollView;
@property(nonatomic, strong) NSArray<HyiNewsCategory *> *categoryArr;
@property(nonatomic, strong) UIFont *normalFont;
@property(nonatomic, strong) UIFont *selectFont;
@property(nonatomic, strong) UIButton *channelAddButton;
@property(nonatomic) BOOL isChannelAdding;
@property(nonatomic, strong) HyiMultiPageScrollView *contentScrollView;
@property(nonatomic) int mainContentWidth;
@property(nonatomic) int mainContentHeight;
@end

@implementation HyiNewsViewController
@synthesize leftItem;
@synthesize centerView;
@synthesize leftView;
@synthesize rightItem;
@synthesize hyiHorArrangeScrollView;
@synthesize categoryArr;
@synthesize normalFont;
@synthesize selectFont;
@synthesize channelAddButton;
@synthesize contentScrollView;
@synthesize mainContentWidth;
@synthesize mainContentHeight;

-(void)viewDidLoad {
    [super viewDidLoad];
    // 数据
    categoryArr = [[HyiNewsChannelDataSource sharedInstance] getNewsCategory];
    normalFont = [UIFont fontWithName:@"Arial" size:14];
    selectFont = [UIFont fontWithName:@"Arial" size:18];
    self.isChannelAdding = NO;
    
    // View
    hyiHorArrangeScrollView = [[HyiHorArrangeScrollView alloc] init];
    hyiHorArrangeScrollView.hyiDataSource = self;
    
    channelAddButton = [[UIButton alloc] init];
    [channelAddButton setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    // TODO-待整理，两个方法的区别
    // 千万不要写成 setBackgroundImage 啊，不然 ImageEdgeInsets 不生效
    [channelAddButton setImage:[UIImage imageNamed:@"channel_nav_plus"] forState:UIControlStateNormal];
    [channelAddButton addTarget:self action:@selector(addChannel:) forControlEvents:UIControlEventTouchUpInside];
    
    // 获取显示区域
    contentScrollView = [[HyiMultiPageScrollView alloc] init];
    
    // TODO-待整理
    // 64 像素偏移问题，UIScrollView 作为第一个元素加入到 self.view 的时候会产生偏移，
    // 下面文章有解决方案，但是不生效，日狗，添加一个 View 倒是可以解决
    // https://www.swiftmi.com/topic/329.html
    UIView *bugFixView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [bugFixView setBackgroundColor:[UIColor greenColor]];

    [self.view addSubview:bugFixView];
    [self.view addSubview:hyiHorArrangeScrollView];
    [self.view addSubview:channelAddButton];
    [self.view addSubview:contentScrollView];
}

-(void)viewDidLayoutSubviews {
    [channelAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        // TODO-待整理
        // 如果完全移除 ScrollView 以外的 View，是需要加 offset
        // make.top.mas_equalTo(self.view.mas_top).offset(STATUS_BAR_HEIGHT + NAVI_BAR_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    [hyiHorArrangeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        // make.top.mas_equalTo(self.view.mas_top).offset(STATUS_BAR_HEIGHT + NAVI_BAR_HEIGHT);
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(channelAddButton.mas_left);
    }];
    
    CGRect viewRect = self.view.bounds;
    mainContentWidth = viewRect.size.width;
    mainContentHeight = viewRect.size.height - TAB_BAR_HEIGHT - 40;
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(mainContentWidth, mainContentHeight));
        make.top.mas_equalTo(hyiHorArrangeScrollView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    self.contentScrollView.hyiDataSource = self;
    self.contentScrollView.hyiDelegate = self;
    
    [leftView setCount:12];
    // 开始动画
    if(leftView != nil)
        [leftView doAnimation];
}

#pragma mark Navigator

-(void)initNavigationBar {
    // TODO-待解决
    // 此处有个Bug:
    // 现在的嵌套格式是 NavigationController 嵌套着一个 TabBarController，NewsViewController
    // 在初次加载的时候不会调用 viewWillAppear 方法。这个问题貌似一直有，后面解决
    [self initLeftView];
    [self initCenterView];
    [self initRightView];
}

- (void)initLeftView {
    if(leftView == nil) {
        leftView = [[HyiLiveView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveViewClicked:)];
        [leftView addGestureRecognizer:tap];
        leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    }
    
    // TODO-待整理
    // 这里一定要加上 tabBarController 才行，NaviController 只会去读这个 tabBarController 的
    // navigationItem 值
    self.tabBarController.navigationItem.leftBarButtonItem = leftItem;
}

-(void)initCenterView {
    if(centerView == nil){
        centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 22)];
        [centerView setImage:[UIImage imageNamed:@"navbar_netease"]];
    }
    
    self.tabBarController.navigationItem.titleView = centerView;
}

-(void)initRightView {
    if(rightItem == nil) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [rightButton setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"search_icon_highlighted"] forState:UIControlStateHighlighted];
        rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }

    self.tabBarController.navigationItem.rightBarButtonItem = rightItem;
}

#pragma mark Click Event

- (void)liveViewClicked:(id)sender {
    [self.tabBarController setSelectedIndex:1];
}

- (void)addChannel:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        if(!self.isChannelAdding){
            channelAddButton.transform = CGAffineTransformMakeRotation(M_PI / 4);
        }else{
            channelAddButton.transform = CGAffineTransformMakeRotation(0);
        }
        self.isChannelAdding = !self.isChannelAdding;
    } completion:^(BOOL finished) {
        // NIL
    }];
}

#pragma mark HyiHorArrangeScrollViewAdapter
-(int)getCount {
    return (int)[categoryArr count];
}

-(UIView *)getView:(int)index withOffset:(int)offset {
    HyiNewsCategory *nc = [categoryArr objectAtIndex:index];
    int fontSize = 16;
    CGSize textSize =[nc.categoryName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    int textActualWidth = textSize.width + 28;// 两边留白
    
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(offset, 0, textActualWidth, 40)];
    [categoryLabel setText:nc.categoryName];
    [categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [categoryLabel setTextColor:TEXT_DARK_GRAY];
    [categoryLabel setFont:normalFont];
    [categoryLabel setBackgroundColor:TRANSPARENT];
    return categoryLabel;
}

-(void)switchSelectView:(UIView *)selectedView withIndex:(int)index withOldView:(UIView *)oldView withOldIndex:(int)oldIndex {
    // TODO-待完善
    // 动画做的有点痛苦
    if(oldView != nil){
        UILabel *oldLabel = (UILabel *)oldView;
        oldLabel.font = normalFont;
        oldLabel.textColor = TEXT_DARK_GRAY;
        oldLabel.transform = CGAffineTransformScale(oldLabel.transform, 1.0, 1.0);
        [UIView animateWithDuration:0.3 animations:^{
            oldLabel.transform = CGAffineTransformScale(oldLabel.transform, 14.0/18.0, 14.0/18.0);
        }];
    }
    
    if(selectedView != nil){
        UILabel *selectLabel = (UILabel *)selectedView;
        selectLabel.textColor = HYI_RED;
        selectLabel.transform = CGAffineTransformScale(selectLabel.transform, 1.0, 1.0);
        [UIView animateWithDuration:0.3 animations:^{
            selectLabel.transform = CGAffineTransformScale(selectLabel.transform, 18.0/14.0, 18.0/14.0);
        }];
    }
    
    [contentScrollView displayViewByIndex:index];
}

#pragma mark HyiMultiPageScrollViewDataSource
-(int)getPageCount {
    return (int)[categoryArr count];
}

-(UIView *)getPageViewByTag:(NSString *)tag {
    HyiNewsTableView *tableView = [[HyiNewsTableView alloc] initWithFrame:CGRectMake(0, 0, mainContentWidth, mainContentHeight)];
    HyiNewsDataSource *ds = [[HyiNewsDataSource alloc] init];
    ds.dataArr = [[[HyiNewsDataMocker alloc] init] loadMockData];
    tableView.hyiNewsDataSource = ds;
    [tableView loadMoreData];
    return tableView;
}

-(NSString *)getPageTagAtIndex:(int)index {
    return [categoryArr objectAtIndex:index].categoryName;
}

#pragma mark HyiMultiPageScrollViewDataDelegate
-(void)select:(int)index withView:(UIView *)view {
    [hyiHorArrangeScrollView setSelectedView:index];
    HyiNewsTableView *tabView = (HyiNewsTableView *)view;
    [tabView viewDidAppear];
}

-(void)didReceiveMemoryWarning {
    [contentScrollView didReceiveMemoryWarning];
}
@end
