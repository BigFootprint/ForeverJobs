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
    
    int offset = 0;
    int height = 0; // 获取所有 View 中最高的高度
    int count = [dataSource getCount];
    for(int index = 0; index < count; index ++){
        UIView *subView = [dataSource getView:index withOffset:offset];
        [self addSubview:subView];
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
