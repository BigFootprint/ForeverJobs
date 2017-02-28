//
//  UIViewTestViewController.m
//  MyP
//
//  Created by 李全民 on 17/2/28.
//  Copyright © 2017年 李全民. All rights reserved.
//

#import "UIViewTestViewController.h"
#import "AddOrRemoveView.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface UIViewTestViewController ()

@end

@implementation UIViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    AddOrRemoveView *superViewA = [[AddOrRemoveView alloc] initWithFrame:CGRectMake(20, 100, 100, 100)];
    [superViewA setBackgroundColor:[UIColor redColor]];
    superViewA.ttag = @"superA";
    [self.view addSubview:superViewA];
    
    AddOrRemoveView *superViewB = [[AddOrRemoveView alloc] initWithFrame:CGRectMake(20, 220, 100, 100)];
    [superViewB setBackgroundColor:[UIColor greenColor]];
    superViewB.ttag = @"superB";
    [self.view addSubview:superViewB];
    
    AddOrRemoveView *subView = [[AddOrRemoveView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
    [subView setBackgroundColor:[UIColor blueColor]];
    subView.ttag = @"sub";
    [superViewA addSubview:subView];
    // 会自动从原来的父 View 中移除，不需要手动移除
    [superViewB addSubview:subView];
    NSLog(@"Done");
}

@end
