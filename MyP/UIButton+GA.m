//
//  UIButton+GA.m
//  MyP
//
//  Created by 李全民 on 16/11/15.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIButton+GA.h"

@implementation UIButton (GA)
- (char * const)ga_labelKey {
    return "ga-label";
}

- (void)setGaLabel:(NSString *)gaLabel{
    if ([self gaLabel] == nil) {
        [self addTarget:self action:@selector(ga_buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    [super setGaLabel:gaLabel];
}

- (void)ga_buttonTouched:(id)sender {
    NSLog(@"%@", [self gaLabel]);
}
@end
