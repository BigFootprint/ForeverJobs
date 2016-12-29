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
@end

@implementation HyiMultiPageScrollView
-(id)init {
    self = [super init];
    if(self){
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
    
}

// 滚动到中间页面
-(void)scrollToCenter{
    CGRect rect = self.bounds;
    [self setContentOffset:CGPointMake(rect.size.width, 0)];
}

// 滚动到第一个页面
-(void)scrollToFirst{
    [self setContentOffset:CGPointMake(0, 0)];
}

// 滚动到最后一个页面
-(void)scrollToLast {
    CGRect rect = self.bounds;
    [self setContentOffset:CGPointMake(rect.size.width * 2, 0)];
}

-(void)setHyiDataSource:(id<HyiMultiPageScrollViewDataSource>)ds {
    if(ds == nil || [ds getPageCount] < 3 || ds == _hyiDataSource)
        return;
    
    _hyiDataSource = ds;
    [self initView];
    [self addSubViewByIndex:0 withPosition:LEFT];
    [self addSubViewByIndex:1 withPosition:CENTER];
    [self addSubViewByIndex:2 withPosition:RIGHT];
}

-(void)addSubViewByIndex:(int)index withPosition:(HyiMultiPageViewPosition)position{
    NSString *tag = [self.hyiDataSource getPageTagAtIndex:index];
    UIView *view = [self.hyiDataSource getPageViewByTag:tag];
    [self.tagViewDic setValue:view forKey:tag];
    
    switch (position) {
        case LEFT:
            [self.firstView addSubview:view];
            break;
        case CENTER:
            [self.centerView addSubview:view];
            break;
        case RIGHT:
            [self.lastView addSubview:view];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    // 内存不足
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}
@end
