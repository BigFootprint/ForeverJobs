//
//  HyiNewsCellDataSource.h
//  MyP
//
//  Created by 李全民 on 16/12/30.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HyiNews;

@protocol HyiNewsCellDataSource <NSObject>
+(instancetype)cellWithTableView:(UITableView *)tableView;
// 返回行高
-(int)getCellHeight;

// 更新数据
-(void)refreshData:(HyiNews *)news;
@end
