//
//  UIButtonViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/10.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIButtonViewController.h"
#import "JobsConstants.h"

@interface UIButtonViewController ()
-(void)clickA;

@end

@implementation UIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];// 不设置这句页面就会卡顿
    
    UIButton *testButtonA = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    testButtonA.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    testButtonA.backgroundColor = [UIColor orangeColor];
    
    [testButtonA setTitle:@"测试按钮" forState:UIControlStateNormal];
    [testButtonA addTarget:self action:@selector(clickA) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testButtonA];
}

-(void)clickA{
    NSLog(@"%@", @"你点了我");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
