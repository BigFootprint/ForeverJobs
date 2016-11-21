//
//  Teacher+CoreDataProperties.m
//  MyP
//
//  Created by 李全民 on 16/11/21.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "Teacher+CoreDataProperties.h"

@implementation Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Teacher"];
}

@dynamic name;
@dynamic age;

@end
