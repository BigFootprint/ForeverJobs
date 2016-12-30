//
//  NewsCellFactory.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNewsCellFactory.h"
#import "HyiNormalNewsCell.h"
#import "HyiImageFlipperNewsCell.h"

@implementation HyiNewsCellFactory
+(UITableViewCell<HyiNewsCellDataSource> *)getCellForNewsType:(HyiNewsType)newsType InTableView:(UITableView *)tableView{
    switch(newsType){
        case HyiNewsNormal:
            return [HyiNormalNewsCell cellWithTableView:tableView];
        case HyiNewsImageFlipper:
            return [HyiImageFlipperNewsCell cellWithTableView:tableView];
        default:
            break;
    }
    return nil;
}
@end
