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
#import "HyiMultiPageScrollView.h"
#import "HyiMultiPageScrollViewDataSource.h"
#import "HyiMultiPageScrollViewDataDelegate.h"
#import "Masonry.h"
#import "JobsConstants.h"
#import "NewsDataSource.h"
#import "Color.h"

@interface NewsViewController () <HyiHorArrangeScrollViewAdapter, HyiMultiPageScrollViewDataSource, HyiMultiPageScrollViewDataDelegate>
@property(nonatomic, strong) UIBarButtonItem *leftItem;
@property(nonatomic, strong) UIImageView *centerView;
@property(nonatomic, strong) HyiHorArrangeScrollView *hyiHorArrangeScrollView;
@property(nonatomic, strong) NSArray<NewsCategory *> *categoryArr;
@property(nonatomic, strong) UIFont *normalFont;
@property(nonatomic, strong) UIFont *selectFont;
@property(nonatomic, strong) UIButton *channelAddButton;
@property(nonatomic) BOOL isChannelAdding;
@property(nonatomic, strong) HyiMultiPageScrollView *contentScrollView;
@end

@implementation NewsViewController
@synthesize leftItem;
@synthesize centerView;
@synthesize hyiHorArrangeScrollView;
@synthesize categoryArr;
@synthesize normalFont;
@synthesize selectFont;
@synthesize channelAddButton;
@synthesize contentScrollView;

-(void)viewDidLoad {
    [super viewDidLoad];
    // 数据
    categoryArr = [[NewsDataSource sharedInstance] getNewsCategory];
    normalFont = [UIFont fontWithName:@"Arial" size:16];
    selectFont = [UIFont fontWithName:@"Arial" size:20];
    self.isChannelAdding = NO;
    
    // View
    hyiHorArrangeScrollView = [[HyiHorArrangeScrollView alloc] init];
    hyiHorArrangeScrollView.hyiDataSource = self;
    
    channelAddButton = [[UIButton alloc] init];
    [channelAddButton setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
    // TODO-待整理，两个方法的区别
    // 千万不要写成 setBackgroundImage 啊，不然 ImageEdgeInsets 不生效
    [channelAddButton setImage:[UIImage imageNamed:@"home_channel_bar_add"] forState:UIControlStateNormal];
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
    
    [contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGRect viewRect = self.view.bounds;
        make.size.mas_equalTo(CGSizeMake(viewRect.size.width, viewRect.size.height - TAB_BAR_HEIGHT - 40));
        make.top.mas_equalTo(hyiHorArrangeScrollView.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    self.contentScrollView.hyiDataSource = self;
    self.contentScrollView.hyiDelegate = self;
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

- (void)liveButtonClicked:(id)sender {
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
    NewsCategory *nc = [categoryArr objectAtIndex:index];
    int fontSize = 16;
    CGSize textSize =[nc.categoryName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    int textActualWidth = textSize.width + 30;// 两边留白
    
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
            oldLabel.transform = CGAffineTransformScale(oldLabel.transform, 0.8, 0.8);
        }];
    }
    
    if(selectedView != nil){
        UILabel *selectLabel = (UILabel *)selectedView;
        selectLabel.textColor = HYI_RED;
        selectLabel.transform = CGAffineTransformScale(selectLabel.transform, 1.0, 1.0);
        [UIView animateWithDuration:0.3 animations:^{
            selectLabel.transform = CGAffineTransformScale(selectLabel.transform, 1.25, 1.25);
        }];
    }
    
    [contentScrollView displayViewByIndex:index];
}

#pragma mark HyiMultiPageScrollViewDataSource
-(int)getPageCount {
    return (int)[categoryArr count];
}

-(UIView *)getPageViewByTag:(NSString *)tag {
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [categoryLabel setText:tag];
    [categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [categoryLabel setTextColor:TEXT_DARK_GRAY];
    [categoryLabel setFont:normalFont];
    [categoryLabel setBackgroundColor:BG_MAIN];
    return categoryLabel;
}

-(NSString *)getPageTagAtIndex:(int)index {
    return [categoryArr objectAtIndex:index].categoryName;
}

#pragma mark HyiMultiPageScrollViewDataDelegate
-(void)select:(int)index {
    [hyiHorArrangeScrollView setSelectedView:index];
}

-(void)didReceiveMemoryWarning {
    [contentScrollView didReceiveMemoryWarning];
}
@end
