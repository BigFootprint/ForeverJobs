//
//  AddOrRemoveView.m
//  MyP
//
//  Created by 李全民 on 17/2/28.
//  Copyright © 2017年 李全民. All rights reserved.
//

#import "AddOrRemoveView.h"

@implementation AddOrRemoveView

-(void)removeFromSuperview {
    [super removeFromSuperview];
    NSLog(@"removeFromSuperview - %@", _ttag);
}

-(void)addSubview:(UIView *)view {
    [super addSubview:view];
    NSLog(@"addSubview - %@", _ttag);
}

-(void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
    NSLog(@"willRemoveSubview - %@", _ttag);
}

@end
