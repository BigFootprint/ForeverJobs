//
//  HyiNews.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNews.h"

@implementation HyiNews
@synthesize newsType;
@end

@implementation HyiNormalNews
-(id)init {
    self = [super init];
    if(self){
        // 不加 self. 无法引用到 newsType，报变量私有错误
        self.newsType = HyiNewsNormal;
    }
    return self;
}
@end

@implementation HyiImageFlipperNews
-(id)init {
    self = [super init];
    if(self){
        // 不加 self. 无法引用到 newsType，报变量私有错误
        self.newsType = HyiNewsImageFlipper;
    }
    return self;
}
@end
