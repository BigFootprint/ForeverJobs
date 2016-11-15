//
//  UIResponder+GA.m
//  MyP
//
//  Created by 李全民 on 16/11/15.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIResponder+GA.h"
#import <objc/runtime.h>

@implementation UIResponder (GA)
- (char * const)ga_labelKey {
    return "ga-label";
}

// GA自动打点的实现
-(void)setGaLabel:(NSString *)label{
    objc_setAssociatedObject(self, [self ga_labelKey], label, OBJC_ASSOCIATION_COPY);
}

-(NSString *)gaLabel{
    return objc_getAssociatedObject(self, [self ga_labelKey]);
}
@end
