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
// TODO-待完善
// 少于三个的情况还没有考虑
@property(nonatomic, strong) UIView *firstView;
@property(nonatomic, strong) UIView *centerView;
@property(nonatomic, strong) UIView *lastView;
@property(nonatomic, strong) NSMutableDictionary *tagViewDic;
@property(nonatomic) int currentIndex;
@end

@implementation HyiMultiPageScrollView
@synthesize currentIndex;
@synthesize hyiDataSource;
@synthesize hyiDelegate;

-(id)init {
    self = [super init];
    if(self){
        [self clearCurrentIndex];
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

    // 清理容器
    if(self.firstView != nil){
        [self.firstView removeFromSuperview];
        [self.centerView removeFromSuperview];
        [self.lastView removeFromSuperview];
    }
    
    // 添加容器 View
    CGRect rect = self.bounds;
    self.firstView = [[UIView alloc] initWithFrame:rect];
    self.centerView = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width * 1, 0, rect.size.width, rect.size.height)];
    self.lastView = [[UIView alloc] initWithFrame:CGRectMake(rect.size.width * 2, 0, rect.size.width, rect.size.height)];
    [self addSubview:self.firstView];
    [self addSubview:self.centerView];
    [self addSubview:self.lastView];
    self.contentSize = CGSizeMake(rect.size.width * 3, rect.size.height);
}

-(void)refreshViewByIndex:(int)index {
    NSString *tagAtIndex = [self.hyiDataSource getPageTagAtIndex:index];
    [self.tagViewDic removeObjectForKey:[self.tagViewDic objectForKey:tagAtIndex]];

    [self clearCurrentIndex];
    [self displayViewByIndex:index];
}

-(void)notifyDataSetChanged {
    [self.tagViewDic removeAllObjects];
    if(currentIndex >= 0 && currentIndex < [self.hyiDataSource getPageCount]){
        int tempIndex = currentIndex;
        [self clearCurrentIndex];
        [self displayViewByIndex:tempIndex];
    } else {
        [self clearCurrentIndex];
        [self displayViewByIndex:0];
    }
}

-(void)clearCurrentIndex {
    currentIndex = -1;
}

-(void)displayViewByIndex:(int)index {
    NSLog(@"%d, %d", index, currentIndex);
    if(hyiDataSource == nil || currentIndex == index){
        return;
    }
    
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
    if(hyiDelegate != nil && hyiDataSource != nil){
        NSString *tag = [hyiDataSource getPageTagAtIndex:index];
        [hyiDelegate select:currentIndex withView:[_tagViewDic objectForKey:tag]];
    }
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
    [self clearCurrentIndex];
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
    int DEVIATION_VALVE = 1;
    
    // 这种写法可能比较难理解，几个 else 不属于同一个范围，后面两周考虑的是特殊情况
    if(offsetX < DEVIATION_VALVE) {
        [self displayViewByIndex:(currentIndex - 1)];
    }else if(offsetX > pageWidth + DEVIATION_VALVE) {
        [self displayViewByIndex:(currentIndex + 1)];
    }else if(currentIndex == 0) {
        [self displayViewByIndex:currentIndex + 1];
    }else if(currentIndex == [hyiDataSource getPageCount] - 1) {
        [self displayViewByIndex:currentIndex - 1];
    }
}
@end
