//
//  SelfViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiSelfViewController.h"
#import "HyiSize.h"
#import "HyiColor.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface HyiSelfViewController ()
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UIButton *settingsButton;
@end

@implementation HyiSelfViewController
@synthesize naviView;
@synthesize settingsButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Navi 部分
    naviView = [[UIView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVI_BAR_HEIGHT)];
    [naviView setBackgroundColor:HYI_RED];
    
    settingsButton = [[UIButton alloc] init];
    [settingsButton setTitle:@"设置" forState:UIControlStateNormal];
    [settingsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    settingsButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
    [settingsButton setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [settingsButton sizeToFit];
    [naviView addSubview:settingsButton];
    
    [self.view addSubview:naviView];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)updateViewConstraints {
    [settingsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(naviView.mas_right).offset(-20);
        make.top.mas_equalTo(naviView.mas_top).offset(32 - STATUS_BAR_HEIGHT);
    }];
    
    [super updateViewConstraints];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

@end
