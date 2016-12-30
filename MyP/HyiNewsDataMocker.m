//
//  DataMocker.m
//  MyP
//
//  Created by 李全民 on 16/12/30.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNewsDataMocker.h"
#import "HyiNews.h"

@interface HyiNewsDataMocker ()
@property(nonatomic) NSMutableArray *dataArray;
@end

@implementation HyiNewsDataMocker
@synthesize dataArray;

-(NSArray<HyiNews *> *)loadMockData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self fullfillDataArr];
    });
    return dataArray;
}

// 填充数组
-(void)fullfillDataArr {
    dataArray = [NSMutableArray array];
    
    // 正常视图
    HyiNormalNews *news = [[HyiNormalNews alloc] init];
    news.imageUrl = @"http://img.mp.itc.cn/upload/20161201/1bb244cdbe504f229dc874e0c57cf63d_th.jpeg";
    news.channel = @"热门";
    news.newsTitle = @"唐嫣甜美装扮现身机场 获男友罗晋蒙面接机";
    news.commentCount = 435;
    [dataArray addObject:news];
}
@end
