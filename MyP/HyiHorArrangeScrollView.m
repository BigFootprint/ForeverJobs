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
@synthesize delegate;
@synthesize currentIndex;
@synthesize positionDic;

-(void)setSelectedView:(int)index{
    if(delegate == nil)
        return;
    
    if(index < [delegate getCount] && index >= 0)
        currentIndex = index;
}

-(int)getCurrentSelectedIndex{
    if(delegate == nil)
        return -1;
    
    return 0;
}

-(void)setDelegate:(id<HyiHorArrangeScrollViewAdapter>)dlg {
    if(dlg == nil)
        return;
    
    // TODO-待整理
    // 第一次这里用的是 self.delegate = dlg，结果是循环调用。
    delegate = dlg;
    if(positionDic == nil){
        positionDic = [NSMutableDictionary dictionary];
    }else{
        [positionDic removeAllObjects];
    }
    
    int position = 0;
    for(int index = 0; index < [dlg getCount]; index ++){
        UIView *subView = [dlg getView:index];
        [self addSubview:subView];
        [positionDic setObject:[NSNumber numberWithInt:position] forKey:[NSNumber numberWithInt:index]];
        position += subView.frame.size.width;
    };
}

-(void)refreshData {
    
}
@end
