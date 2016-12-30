//
//  HyiNews.h
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HyiNewsType) {
    HyiNewsNormal = 0xCAFE,
    HyiNewsImageFlipper // 图片浏览型，可滑动
};

@interface HyiNews : NSObject
@property (nonatomic) HyiNewsType newsType;
@property (nonatomic) int cellHeight;
@end

@interface HyiNormalNews : HyiNews
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) NSString *newsTitle;
@property (nonatomic) NSString *channel;
@property (nonatomic) int commentCount;
@property (nonatomic) NSString *tip;
@end

@interface HyiImageFlipperNews : HyiNews
@property (nonatomic) NSArray<NSString *> *imageArr;
@property (nonatomic) NSString *newsTitle;
@end
