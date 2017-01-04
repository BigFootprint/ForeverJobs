//
//  DataMocker.m
//  MyP
//
//  Created by 李全民 on 16/12/30.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNewsDataMocker.h"
#import "HyiNews.h"
#import "HyiRandomUtils.h"

@interface HyiNewsDataMocker ()
@property(nonatomic, strong) NSMutableArray<HyiNews *> *dataArray;
@end

@implementation HyiNewsDataMocker
@synthesize dataArray;

-(NSArray<HyiNews *> *)loadMockData{
    [self fullfillDataArr];
    return dataArray;
}

// 填充数组
-(void)fullfillDataArr {
    dataArray = [NSMutableArray array];
    
    // 滑动图片视图
    HyiImageFlipperNews *news_1 = [[HyiImageFlipperNews alloc] init];
    news_1.imageArr = @[];
    if([HyiRandomUtils yesOrNo]){
        news_1.newsTitle = @"台风“洛坦”袭菲律宾 致6人死18人失踪 房屋损毁1000间 损失约9000万美元";
    }else{
        news_1.newsTitle = @"台风“洛坦”袭菲律宾 致6人死18人失踪";
    }
    news_1.imageArr = @[@"ty_a.jpg", @"ty_b.jpg", @"ty_c.jpg", @"ty_d.jpg"];
    [dataArray addObject:news_1];
    
    // 正常视图
    HyiNormalNews *news = [[HyiNormalNews alloc] init];
    news.imageUrl = @"http://img.mp.itc.cn/upload/20161201/1bb244cdbe504f229dc874e0c57cf63d_th.jpeg";
    news.channel = @"热门";
    news.newsTitle = @"唐嫣甜美装扮现身机场 获男友罗晋蒙面接机";
    news.commentCount = 435;
    [dataArray addObject:news];
}
@end
