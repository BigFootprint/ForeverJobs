//
//  MultiPageScrollViewDataSource.h
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HyiMultiPageScrollViewDataSource <NSObject>
-(int)getPageCount;
// 根据 Tag 获取 View
-(UIView *)getPageViewByTag:(NSString *)tag;
// 为页面设置一个Tag，目的是为了可以任意插入新的 View
-(NSString *)getPageTagAtIndex:(int)index;
@end
