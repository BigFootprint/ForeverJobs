//
//  UIWindowViewController.m
//  MyP
//
//  Created by 李全民 on 17/1/11.
//  Copyright © 2017年 李全民. All rights reserved.
//

#import "UIWindowViewController.h"
#import "JobsConstants.h"
#import "UITextFieldViewController.h"

@interface UIWindowViewController ()
@property (nonatomic, strong) UIWindow *greenWindow, *redWindow, *yellowWindow, *blueWindow, *testWindow;
-(void)clickBtn:(id)sender;
@end

@implementation UIWindowViewController
@synthesize greenWindow;
@synthesize redWindow;
@synthesize yellowWindow;
@synthesize blueWindow;
@synthesize testWindow;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    UIButton *btnA = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    [btnA setTitle:@"测试-A" forState:UIControlStateNormal];
    [btnA addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    greenWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 80, 100, 100)];
    greenWindow.backgroundColor = [UIColor greenColor];
    greenWindow.windowLevel = UIWindowLevelNormal;
    greenWindow.hidden = NO;
    [greenWindow addSubview:btnA];
    
    redWindow = [[UIWindow alloc] initWithFrame:CGRectMake(50, 80, 100, 100)];
    redWindow.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:0.5];
    redWindow.windowLevel = UIWindowLevelAlert;
    redWindow.hidden = NO;
    
    UIButton *btnB = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 30)];
    [btnB setTitle:@"测试-B" forState:UIControlStateNormal];
    [btnB addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    yellowWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 150, 100, 100)];
    yellowWindow.backgroundColor = [UIColor yellowColor];
    yellowWindow.windowLevel = UIWindowLevelNormal;
    yellowWindow.hidden = NO;
    [yellowWindow addSubview:btnB];
    
    int width = [[UIScreen mainScreen] bounds].size.width;
    UITextFieldViewController *testVC1 = [[UITextFieldViewController alloc] init];
    blueWindow = [[UIWindow alloc] initWithFrame:CGRectMake(50, 150, width, 120)];
    blueWindow.backgroundColor = [UIColor blueColor];
    blueWindow.windowLevel = UIWindowLevelNormal;
    blueWindow.rootViewController = testVC1;
    blueWindow.hidden = NO;
    
    UITextFieldViewController *testVC2 = [[UITextFieldViewController alloc] init];
    testWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 380, width, 120)];
    testWindow.backgroundColor = [UIColor orangeColor];
    testWindow.windowLevel = UIWindowLevelNormal;
    testWindow.rootViewController = testVC2;
    testWindow.hidden = NO;
}

-(void)clickBtn:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"%@", btn.titleLabel.text);
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
