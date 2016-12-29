//
//  HyiHorArrangeScrollView.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiHorArrangeScrollView.h"

@interface HyiHorArrangeScrollView ()
@property(nonatomic, readonly) NSMutableDictionary *positionDic;
@property(nonatomic, readonly) NSMutableArray<ViewInfo *> *viewArr;
@property(nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property(nonatomic, weak) UIView *currentView;
@property(nonatomic) int currentIndex;
@end

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

@implementation HyiHorArrangeScrollView
@synthesize hyiDataSource;
@synthesize currentIndex;
@synthesize positionDic;
@synthesize tapGesture;
@synthesize viewArr;
@synthesize currentView;

-(void)setSelectedView:(int)index{
    if(hyiDataSource == nil)
        return;
    
    if(index < [hyiDataSource getCount] && index >= 0)
        currentIndex = index;
}

-(int)getCurrentSelectedIndex{
    if(hyiDataSource == nil)
        return -1;
    
    return 0;
}

-(void)initContext {
    if(positionDic == nil){
        positionDic = [NSMutableDictionary dictionary];
    }else{
        [positionDic removeAllObjects];
    }
    
    if(viewArr == nil){
        viewArr = [NSMutableArray array];
    }else{
        [viewArr removeAllObjects];
    }
    
    if(tapGesture == nil){
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    }
}

// Tap 事件处理
-(void)tapView:(UITapGestureRecognizer *)gesture{
    // 获取点击位置
    CGPoint point = [gesture locationInView:self];
    int xOffset = point.x;
    int index = [self findIndexByOffset:xOffset];
    if(index == currentIndex)
        return;
    
    UIView *selectView = [viewArr objectAtIndex:index].view;
    if([hyiDataSource respondsToSelector:@selector(switchSelectView:withIndex:withOldView:withOldIndex:)]){
        [hyiDataSource switchSelectView:selectView withIndex:index withOldView:currentView withOldIndex:currentIndex];
    }
    currentIndex = index;
    currentView = selectView;
}

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
}

-(void)refreshData {
    
}
@end
