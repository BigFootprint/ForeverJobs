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
-(int)getCellHeight;
-(void)refreshData:(HyiNews *)news;
@end
