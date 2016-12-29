//
//  MultiPageScrollView.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiMultiPageScrollView.h"
@interface HyiMultiPageScrollView ()<UIScrollViewDelegate>
// 下面是三个容器
// TODO：少于三个的情况还没有考虑
@property(nonatomic, strong) UIView *firstView;
@property(nonatomic, strong) UIView *centerView;
@property(nonatomic, strong) UIView *lastView;
@property(nonatomic, strong) NSMutableDictionary *tagViewDic;
@property(nonatomic) int currentIndex;
@end

@implementation HyiMultiPageScrollView
@synthesize currentIndex;
@synthesize hyiDataSource;

-(id)init {
    self = [super init];
    if(self){
        self.currentIndex = -1;
        self.tagViewDic = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)initView {
    // 设置 ScrollView 的属性
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = YES;
    self.pagingEnabled = YES;
    self.delegate = self;

    // 添加容器 View
    CGRect rect = self.bounds;
    self.firstView = [[UIView alloc] initWithFrame:rect];
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width * 1, 0, rect.size.width, rect.size.height)];
    self.lastView = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width * 2, 0, rect.size.width, rect.size.height)];
    [self addSubview:self.firstView];
    [self addSubview:self.centerView];
    [self addSubview:self.lastView];
    [self.firstView setBackgroundColor:[UIColor redColor]];
    [self.centerView setBackgroundColor:[UIColor yellowColor]];
    [self.lastView setBackgroundColor:[UIColor orangeColor]];
    self.contentSize = CGSizeMake(rect.size.width * 3, rect.size.height);
}

-(void)refreshViewByIndex:(int)index {
    
}

-(void)displayViewByIndex:(int)index {
    if(hyiDataSource == nil || currentIndex == index)
        return;
    
    if(index < 0 || index >= [hyiDataSource getPageCount]) // index 非法
        return;
    
    if(index == 0){//显示第 0 页
        [self addSubViewByIndex:0 withPosition:LEFT];
        [self addSubViewByIndex:1 withPosition:CENTER];
        [self addSubViewByIndex:2 withPosition:RIGHT];
        [self scrollTo:LEFT];
    }else if(index == [hyiDataSource getPageCount] - 1){//显示最后一页
        [self addSubViewByIndex:index - 2 withPosition:LEFT];
        [self addSubViewByIndex:index - 1 withPosition:CENTER];
        [self addSubViewByIndex:index withPosition:RIGHT];
        [self scrollTo:RIGHT];
    }else{
        [self addSubViewByIndex:index - 1 withPosition:LEFT];
        [self addSubViewByIndex:index withPosition:CENTER];
        [self addSubViewByIndex:index + 1 withPosition:RIGHT];
        [self scrollTo:CENTER];
    }
    currentIndex = index;
}

// 滚动到中间页面
-(void)scrollTo:(HyiMultiPageViewPosition)position{
    int pageWidth = self.bounds.size.width;
    int scrollOffset = 0;
    switch (position) {
        case CENTER:
            scrollOffset = pageWidth;
            break;
        case RIGHT:
            scrollOffset = pageWidth * 2;
            break;
        default:
            break;
    }
    [self setContentOffset:CGPointMake(scrollOffset, 0)];
}

-(void)setHyiDataSource:(id<HyiMultiPageScrollViewDataSource>)ds {
    if(ds == nil || [ds getPageCount] < 3 || ds == hyiDataSource)
        return;
    
    hyiDataSource = ds;
    [self initView];
    [self displayViewByIndex:0];
}

-(void)addSubViewByIndex:(int)index withPosition:(HyiMultiPageViewPosition)position{
    NSString *tag = [self.hyiDataSource getPageTagAtIndex:index];
    UIView *view = [_tagViewDic objectForKey:tag];
    if(view == nil)
        view = [self.hyiDataSource getPageViewByTag:tag];
    
    [self.tagViewDic setValue:view forKey:tag];
    
    switch (position) {
        case LEFT:
            [self clearSubViews:self.firstView];
            [self.firstView addSubview:view];
            break;
        case CENTER:
            [self clearSubViews:self.centerView];
            [self.centerView addSubview:view];
            break;
        case RIGHT:
            [self clearSubViews:self.lastView];
            [self.lastView addSubview:view];
            break;
        default:
            break;
    }
}

-(void)clearSubViews:(UIView *)view {
    NSArray<UIView *> *arr = [view subviews];
    for(int index = 0; index < [arr count]; index ++){
        [[arr objectAtIndex:index] removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    // 内存不足
    if([_tagViewDic count] <= 3)
        return; // 无须释放，否则左右滑动会出问题
    
    // 只保留当前 View 和前后两者的 View
    for(int index = 0; index < [hyiDataSource getPageCount]; index ++){
        if(index < currentIndex - 1 || index > currentIndex + 1){
            NSString *tag = [hyiDataSource getPageTagAtIndex:index];
            [_tagViewDic removeObjectForKey:tag];
        }
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int offsetX = [scrollView contentOffset].x;
    int pageWidth = self.bounds.size.width;
    if(offsetX < 1){ //防止误差
        [self displayViewByIndex:(currentIndex - 1)];
    }else if(offsetX > pageWidth + 1){
        [self displayViewByIndex:(currentIndex + 1)];
    }
}
@end
