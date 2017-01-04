//
//  LiveViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiLiveViewController.h"

@interface HyiLiveViewController ()
@property(nonatomic, strong) UIBarButtonItem *rightItem;
@end

@implementation HyiLiveViewController
@synthesize rightItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated {
    
}

-(void)initNavigationBar {
    self.tabBarController.navigationItem.leftBarButtonItems = nil;
    self.tabBarController.navigationItem.hidesBackButton = YES;
    
    [self initCenterView];
    [self initRightView];
}

#pragma mark Navigator
-(void)initCenterView {
    
}

-(void)initRightView {
    if(rightItem == nil) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [rightButton setImage:[UIImage imageNamed:@"nav_remind_view_icon"] forState:UIControlStateNormal];
        rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
