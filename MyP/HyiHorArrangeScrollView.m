//
//  HyiHorArrangeScrollView.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiHorArrangeScrollView.h"

@interface HyiHorArrangeScrollView ()
@property(nonatomic) int currentIndex;
@property(nonatomic, readonly) NSMutableDictionary *positionDic;
@end

@implementation HyiHorArrangeScrollView
@synthesize hyiDataSource;
@synthesize currentIndex;
@synthesize positionDic;

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

-(void)setHyiDataSource:(id<HyiHorArrangeScrollViewAdapter>)dataSource {
    if(dataSource == nil)
        return;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = NO;
    
    // TODO-待整理
    // 第一次这里用的是 self.delegate = dlg，结果是循环调用。
    hyiDataSource = dataSource;
    if(positionDic == nil){
        positionDic = [NSMutableDictionary dictionary];
    }else{
        [positionDic removeAllObjects];
    }
    
    int position = 0;
    int count = [dataSource getCount];
    for(int index = 0; index < count; index ++){
        UIView *subView = [dataSource getView:index];
        [self addSubview:subView];
        [positionDic setObject:[NSNumber numberWithInt:position] forKey:[NSNumber numberWithInt:index]];
        position += subView.frame.size.width;
    };
}

-(void)refreshData {
    
}
@end
