//
//  HyiNewsTableView.h
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HyiNewsDataSource;

@interface HyiNewsTableView : UITableView
@property (nonatomic, strong) HyiNewsDataSource *hyiNewsDataSource;
// 加载更多数据
-(void)loadMoreData;

// 刷新数据
-(void)refreshData;

// View 将显示
-(void)viewDidAppear;
@end
