//
//  RandomUtils.m
//  MyP
//
//  Created by 李全民 on 17/1/4.
//  Copyright © 2017年 李全民. All rights reserved.
//

#import "HyiRandomUtils.h"

@implementation HyiRandomUtils
+(BOOL) yesOrNo {
    return arc4random() % 100 <= 49;
}
@end
