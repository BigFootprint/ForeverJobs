//
//  NewsDataSource.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "NewsDataSource.h"
#ifndef NewsDataSource_PAGE_DATASOURCE_SIZE
#define PAGE_DATASOURCE_SIZE 15 //每页展示 15 个
#endif

@interface NewsDataSource ()
@property (nonatomic) int pageIndex;
@end

@implementation NewsDataSource
@synthesize pageIndex;

// 加载更多数据
-(void)loadMoreData {

}

// 刷新数据
-(void)refreshData {

}
@end
