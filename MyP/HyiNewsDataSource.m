//
//  NewsDataSource.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNewsDataSource.h"


#ifndef NewsDataSource_PAGE_DATASOURCE_SIZE
#define PAGE_DATASOURCE_SIZE 15 //每页展示 15 个
#endif

@interface HyiNewsDataSource ()
@property (nonatomic) int pageIndex;
@end

@implementation HyiNewsDataSource
@synthesize pageIndex;
@synthesize dataArr;

// 加载更多数据，Block
-(void)loadMoreData:(void (^)(NSArray<HyiNews *> *data))callbaclBlock {
    // TODO-待整理
    // Block 的内存泄露
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [NSThread sleepForTimeInterval:[strongSelf getDataAcquireDuration]];
        __weak typeof(self) weakSelf_B = strongSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf_B) strongSelf_B = weakSelf_B;
            if(![self isEnd])
                pageIndex ++;
            
            if(callbaclBlock){
                callbaclBlock([strongSelf_B getDataByIndex:pageIndex]);
            }
        });
    });
}

// 刷新数据，Block
-(void)refreshData:(void (^)(NSArray<HyiNews *> *data))callbackBlock {
    pageIndex = 0;
    [self loadMoreData:callbackBlock];
}

// 产生 3 秒内的随机时长，模拟网络请求
-(float)getDataAcquireDuration{
    return (arc4random() % 300) / 100.0f;
}

-(NSArray<HyiNews *> *)getDataByIndex:(int)index {
    int dataCount = index * PAGE_DATASOURCE_SIZE;
    if(dataCount >= [dataArr count])
        return [dataArr copy];
    
    return [dataArr subarrayWithRange:NSMakeRange(0, dataCount)];
}

// 数据是否已经加载完成
-(BOOL)isEnd {
    if(dataArr == nil)
        return YES;
    
    return PAGE_SIZE * pageIndex >= [dataArr count];
}
@end
