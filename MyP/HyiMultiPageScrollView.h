//
//  MultiPageScrollView.h
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HyiMultiPageScrollViewDataSource.h"
#import "HyiMultiPageScrollViewDataDelegate.h"

typedef NS_ENUM(NSUInteger, HyiMultiPageViewPosition) {
    LEFT = 0,
    CENTER,
    RIGHT
};

@interface HyiMultiPageScrollView : UIScrollView
@property (nonatomic, weak) id<HyiMultiPageScrollViewDataSource> hyiDataSource;
@property (nonatomic, weak) id<HyiMultiPageScrollViewDataDelegate> hyiDelegate;
// 根据 Index 刷新页面
-(void)refreshViewByIndex:(int)index;
// 根据 Index 展示页面
-(void)displayViewByIndex:(int)index;
// 内存告警, 释放非必要引用的 View
- (void)didReceiveMemoryWarning;
@end
