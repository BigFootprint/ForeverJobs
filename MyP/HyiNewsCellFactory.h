//
//  NewsCellFactory.h
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HyiNews.h"
#import "HyiNewsCellDataSource.h"

@interface HyiNewsCellFactory : NSObject
+(UITableViewCell<HyiNewsCellDataSource> *)getCellForNewsType:(HyiNewsType)newsType InTableView:(UITableView *)tableView;
@end
