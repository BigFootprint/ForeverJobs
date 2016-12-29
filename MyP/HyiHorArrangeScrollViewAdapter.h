//
//  HyiHorArrangeScrollViewAdapter.h
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HyiHorArrangeScrollViewAdapter <NSObject>

@required
// 获取 View 的数量
-(int)getCount;

// 根据 Index 获取 View，同时告知当前 View 排列后的偏移，便于下一个 View 设置 Frame
-(UIView *)getView:(int)index withOffset:(int)offset;

@optional
// 切换 View 后的回调
-(void)switchSelectView:(UIView *)selectedView withIndex:(int)index withOldView:(UIView *)oldView withOldIndex:(int)oldIndex;
@end
