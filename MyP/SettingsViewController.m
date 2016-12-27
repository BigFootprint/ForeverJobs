//
//  SettingsViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/8.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

-(void)loadView{
    [super loadView];
    NSLog(@"VCLifeCycle-loadView");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"VCLifeCycle-viewDidLoad");
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"VCLifeCycle-viewWillAppear");
    self.tabBarController.navigationItem.title = @"设置";
}

-(void)viewWillLayoutSubviews{
    NSLog(@"VCLifeCycle-viewWillLayoutSubviews");
}

-(void)viewDidLayoutSubviews{
    NSLog(@"VCLifeCycle-viewDidLayoutSubviews");
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"VCLifeCycle-viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"VCLifeCycle-viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"VCLifeCycle-viewDidDisappear");
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
