//
//  NewsDataSource.h
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//  模拟数据源

#import <Foundation/Foundation.h>
@class HyiNews;

@interface HyiNewsDataSource : NSObject
//@property (nonatomic, copy) NSString *url; // 实际开发中应该是一个客户端接口 Url
@property (nonatomic, strong) NSArray<HyiNews *> *dataArr; // 存放实际数据

// 加载更多数据，Block
-(void)loadMoreData:(void (^)(NSArray<HyiNews *> *data))callbaclBlock;

// 刷新数据，Block
-(void)refreshData:(void (^)(NSArray<HyiNews *> *data))callbackBlock;

// 数据是否已经加载完成
-(BOOL)isEnd;
@end
