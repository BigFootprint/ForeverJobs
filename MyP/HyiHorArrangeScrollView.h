//
//  HyiHorArrangeScrollView.h
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HyiHorArrangeScrollViewAdapter.h"

@interface HyiHorArrangeScrollView : UIScrollView
@property(nonatomic, weak) id<HyiHorArrangeScrollViewAdapter> hyiDataSource;
// 设置选中的 View 下标
-(void)setSelectedView:(int)index;
// 获取当前选中的 View 的下标
-(int)getCurrentSelectedIndex;
// 刷新数据
-(void)refreshData;
@end

@interface ViewInfo : NSObject
@property(nonatomic, strong) UIView *view;
@property(nonatomic) int position;

-(id)initWithView:(UIView *)view andPosition:(int)position;
@end
