//
//  HyiBaseViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/27.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiBaseViewController.h"
#import "HyiColor.h"

@interface HyiBaseViewController ()

@end

@implementation HyiBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BG_MAIN];
}

-(void)viewWillAppear:(BOOL)animated {
    [self initNavigationBar];
}

-(void)initNavigationBar {
    
}

@end
