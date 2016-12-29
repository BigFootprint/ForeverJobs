//
//  NewsDataSource.h
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//  模拟数据源

#import <Foundation/Foundation.h>
@class HyiNews;

@interface NewsDataSource : NSObject
//@property (nonatomic, copy) NSString *url; // 实际开发中应该是一个客户端接口 Url
@property (nonatomic, copy) NSArray<HyiNews *> *dataArr; // 存放实际数据

// 加载更多数据，Block
-(void)loadMoreData;

// 刷新数据，Block
-(void)refreshData;
@end
