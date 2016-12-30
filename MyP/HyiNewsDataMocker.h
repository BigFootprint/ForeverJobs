//
//  DataMocker.h
//  MyP
//
//  Created by 李全民 on 16/12/30.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HyiNews;

@interface HyiNewsDataMocker : NSObject

// 加载 mock 数据
-(NSArray<HyiNews *> *)loadMockData;
@end
