//
//  HyiHorArrangeScrollViewAdapter.h
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HyiHorArrangeScrollViewAdapter <NSObject>

@required
-(int)getCount;
-(UIView *)getView:(int)index;

@optional
-(void)selectView:(UIView *)selectedView;

@end
