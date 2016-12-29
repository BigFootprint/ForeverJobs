//
//  NewsDataSource.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "NewsChannelDataSource.h"

@implementation NewsChannelDataSource
static NewsChannelDataSource *dataSource;
static NSArray *categoryArr;

+(NewsChannelDataSource *) sharedInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        dataSource = [[super allocWithZone:NULL] init] ;
        
        categoryArr = @[@"头条", @"要闻", @"轻松一刻", @"科技", @"手机", @"视频", @"历史", @"漫画", @"汽车",
                        @"娱乐", @"热点", @"体育", @"直播", @"房产", @"股票", @"健康", @"美女", @"数码"];
    }) ;
    
    return dataSource ;
}

-(NSArray<NewsCategory *> *)getNewsCategory{
    NSMutableArray *arr = [NSMutableArray array];
    for(int index = 0; index < [categoryArr count]; index ++){
        NewsCategory *c = [[NewsCategory alloc] init];
        c.categoryName = [categoryArr objectAtIndex:index];
        [arr addObject:c];
    }
    return arr;
}
@end
