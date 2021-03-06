//
//  HyiHorArrangeScrollView.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiHorArrangeScrollView.h"

@implementation ViewInfo
@synthesize view;
@synthesize position;

-(id)initWithView:(UIView *)v andPosition:(int)p {
    self = [super init];
    if(self){
        view = v;
        position = p;
    }
    return self;
}
@end

@interface HyiHorArrangeScrollView ()
@property(nonatomic, readonly) NSMutableDictionary *positionDic;
@property(nonatomic, readonly) NSMutableArray<ViewInfo *> *viewArr;
@property(nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property(nonatomic, weak) UIView *currentView;
@property(nonatomic) int currentIndex;
@end

@implementation HyiHorArrangeScrollView
@synthesize hyiDataSource;
@synthesize currentIndex;
@synthesize positionDic;
@synthesize tapGesture;
@synthesize viewArr;
@synthesize currentView;

-(id)init{
    self = [super init];
    if(self){
        positionDic = [NSMutableDictionary dictionary];
        viewArr = [NSMutableArray array];
        currentIndex = -1;
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    }
    return self;
}

-(void)setSelectedView:(int)index{
    if(hyiDataSource == nil)
        return;
    
    if(index >= [hyiDataSource getCount] || index < 0)
        return;
    
    UIView *selectView = [viewArr objectAtIndex:index].view;
    int tempIndex = currentIndex;
    UIView *tempView = currentView;
    currentIndex = index;
    currentView = selectView;
    if([hyiDataSource respondsToSelector:@selector(switchSelectView:withIndex:withOldView:withOldIndex:)]){
        [hyiDataSource switchSelectView:selectView withIndex:index withOldView:tempView withOldIndex:tempIndex];
    }
    
    [self adjustSelectedViewPosition];
}

// 调整被选中项的位置，使它一直显示在屏幕上，尽可能的显示在组件的中间
-(void)adjustSelectedViewPosition {
    ViewInfo *info = [viewArr objectAtIndex:currentIndex];
    int centerOffset = info.position + [info.view bounds].size.width / 2;
    int viewHalfWidth = [self bounds].size.width / 2;
    int offset = centerOffset - viewHalfWidth >= 0 ? centerOffset - viewHalfWidth : 0;
    
    if(offset + [self bounds].size.width > self.contentSize.width){
        offset = self.contentSize.width - [self bounds].size.width;
    }
    // TODO-待解决
    // 页面刚打开的时候，viewHalfWidth 为0，需要仔细研究一下 View 的这些属性什么时候生效
    if(viewHalfWidth == 0){
        offset = 0;
    }
    [self setContentOffset:CGPointMake(offset, 0) animated:YES];
}

-(int)getCurrentSelectedIndex{
    if(hyiDataSource == nil)
        return -1;
    
    return 0;
}

-(void)initContext {
    [positionDic removeAllObjects];
    [viewArr removeAllObjects];
}

// Tap 事件处理
-(void)tapView:(UITapGestureRecognizer *)gesture{
    // 获取点击位置
    CGPoint point = [gesture locationInView:self];
    int xOffset = point.x;
    int index = [self findIndexByOffset:xOffset];
    if(index == currentIndex)
        return;
    
    [self setSelectedView:index];
}

/**
 * 通过 x 轴上的偏移量查找 View 的下标。
 */
-(int)findIndexByOffset:(int)offset{
    for(int index = 0; index < [viewArr count] - 1; index ++){
        if(offset > [viewArr objectAtIndex:index].position && offset < [viewArr objectAtIndex:(index + 1)].position){
            return index;
        }
    }
    
    return (int)[viewArr count] - 1;
}

-(void)setHyiDataSource:(id<HyiHorArrangeScrollViewAdapter>)dataSource {
    if(dataSource == nil)
        return;
    [self initContext];
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = NO;
    self.bounces = YES;
    
    // TODO-待整理
    // 第一次这里用的是 self.delegate = dlg，结果是循环调用。
    hyiDataSource = dataSource;
    [self addGestureRecognizer:tapGesture];
    
    int offset = 0;
    int height = 0; // 获取所有 View 中最高的高度
    int count = [dataSource getCount];
    for(int index = 0; index < count; index ++){
        UIView *subView = [dataSource getView:index withOffset:offset];
        [self addSubview:subView];
        
        // 记录Info
        [viewArr addObject:[[ViewInfo alloc]initWithView:subView andPosition:offset]];
        
        if(subView.frame.size.height > height)
            height = subView.frame.size.height;
        [positionDic setObject:[NSNumber numberWithInt:offset] forKey:[NSNumber numberWithInt:index]];
        offset += subView.frame.size.width;
    };
    self.contentSize = CGSizeMake(offset, height);
    // 默认选中第0个
    [self setSelectedView:0];
}

-(void)refreshData {
    
}
@end
