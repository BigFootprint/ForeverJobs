//
//  NewsDataSource.h
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HyiNewsCategory.h"

@interface HyiNewsChannelDataSource : NSObject
+(HyiNewsChannelDataSource *) sharedInstance;

-(NSArray<HyiNewsCategory *> *)getNewsCategory;
@end
