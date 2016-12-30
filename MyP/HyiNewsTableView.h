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
-(void)loadMoreData;
-(void)refreshData;
@end
