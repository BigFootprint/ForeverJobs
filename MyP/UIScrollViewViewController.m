//
//  UIScrollViewViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/27.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIScrollViewViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

#define VIEW_COUNT 4 // 视图页数

@interface UIScrollViewViewController ()<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;

@property(nonatomic) int pageWidth;
@property(nonatomic) int pageHeight;

-(void)selectPage:(id)sender;
@end

@implementation UIScrollViewViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize pageWidth;
@synthesize pageHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    // 计算尺寸
    CGRect bounds = self.view.bounds;
    pageWidth =  bounds.size.width;
    int startY = NAVI_BAR_HEIGHT + STATUS_BAR_HEIGHT;
    pageHeight = bounds.size.height - startY;
    
    // 初始化 Scrollview
    scrollView = [[UIScrollView alloc] init];
    scrollView.contentSize = CGSizeMake(pageWidth * VIEW_COUNT, pageHeight);
    // 设置翻页效果，可以整屏翻动
    scrollView.pagingEnabled = YES;
    // 不允许反弹
    scrollView.bounces = NO;
    // 不显示水平滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    
    // 添加 View
    for(int index = 0; index < VIEW_COUNT; index ++){        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(index * pageWidth, 0, pageWidth, pageHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"第 %d 页", index + 1];
        label.font = [UIFont fontWithName:@"Arial" size:20];
        if(index % 2 == 0){
            [label setBackgroundColor:[UIColor orangeColor]];
        }
        [scrollView addSubview:label];
    }
    
    // 初始化 UIPageControl
    pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = VIEW_COUNT;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    [pageControl sizeToFit];
    [pageControl addTarget:self action:@selector(selectPage:) forControlEvents:UIControlEventValueChanged];
    
    // 组装
    [self.view addSubview:scrollView];
    [self.view addSubview:pageControl];
    
    // 放置 子View
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
}

-(void)selectPage:(id)sender{
    [scrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width * pageControl.currentPage, 0)];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sv{
    int page = (sv.contentOffset.x + pageWidth / 2) / pageWidth;
    [pageControl setCurrentPage:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
