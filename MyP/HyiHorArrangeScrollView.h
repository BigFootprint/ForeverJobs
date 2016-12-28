//
//  HyiHorArrangeScrollView.h
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HyiHorArrangeScrollViewAdapter.h"

@interface HyiHorArrangeScrollView : UIScrollView
@property(nonatomic, weak) id<HyiHorArrangeScrollViewAdapter> hyiDataSource;

-(void)setSelectedView:(int)index;
-(int)getCurrentSelectedIndex;
-(void)refreshData;
@end
