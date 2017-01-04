//
//  SelfViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiSelfViewController.h"

@interface HyiSelfViewController ()

@end

@implementation HyiSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
