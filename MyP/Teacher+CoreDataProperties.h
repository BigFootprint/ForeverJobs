//
//  Teacher+CoreDataProperties.h
//  MyP
//
//  Created by 李全民 on 16/11/21.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "Teacher+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;

@end

NS_ASSUME_NONNULL_END
