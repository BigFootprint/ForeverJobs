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
    [self.view setBackgroundColor:ANDROID_BLUE];//不设置这句页面就会卡顿
    
    UIButton *testButtonA = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    testButtonA.center = CGPointMake(screenSize.width/2, screenSize.height/2 - 60 * 3);
    testButtonA.backgroundColor = [UIColor orangeColor];
    [testButtonA setTitle:@"按钮基本" forState:UIControlStateNormal];
    [testButtonA setTitle:@"按钮基本-Selected" forState:UIControlStateHighlighted];
    [testButtonA addTarget:self action:@selector(clickA) forControlEvents:UIControlEventTouchUpInside];
    testButtonA.showsTouchWhenHighlighted = YES; //显示一个亮点
    [testButtonA setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton *testButtonB = [UIButton buttonWithType:UIButtonTypeContactAdd];
    testButtonB.frame = CGRectMake(0, 0, 200, 50);
    testButtonB.center = CGPointMake(screenSize.width/2, screenSize.height/2 - 60 * 2);
    testButtonB.backgroundColor = [UIColor orangeColor];
    [testButtonB setTitle:@"Button 风格" forState:UIControlStateNormal];
    
    UIButton *testButtonC = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    testButtonC.center = CGPointMake(screenSize.width/2, screenSize.height/2 - 60);
    testButtonC.backgroundColor = [UIColor orangeColor];
    [testButtonC setTitle:@"背景" forState:UIControlStateNormal];
    [testButtonC setImage:[UIImage imageNamed:@"bg_sky"] forState:UIControlStateNormal];
    
    UIButton *testButtonD = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    testButtonD.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    testButtonD.backgroundColor = [UIColor orangeColor];
    [testButtonD setTitle:@"阴影" forState:UIControlStateNormal];
    [testButtonD setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testButtonD.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    
    UIButton *testButtonE = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    testButtonE.center = CGPointMake(screenSize.width/2, screenSize.height/2 + 60);
    testButtonE.backgroundColor = [UIColor orangeColor];
    testButtonE.titleLabel.font = [UIFont systemFontOfSize:24];
    [testButtonE setTitle:@"字体" forState:UIControlStateNormal];
    [testButtonE.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    
    UIButton *testButtonF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    testButtonF.frame = CGRectMake(0, 0, 200, 50);
    testButtonF.layer.cornerRadius = 10;
    testButtonF.center = CGPointMake(screenSize.width/2, screenSize.height/2 + 2 * 60);
    testButtonF.backgroundColor = [UIColor orangeColor];
    [testButtonF setTitle:@"形状" forState:UIControlStateNormal];
    
    [self.view addSubview:testButtonA];
    [self.view addSubview:testButtonB];
    [self.view addSubview:testButtonC];
    [self.view addSubview:testButtonD];
    [self.view addSubview:testButtonE];
    [self.view addSubview:testButtonF];
}

-(void)clickA{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UIButton学习" message:@"你点击了我！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dialog-好的");
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
