//
//  LayoutViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/14.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "LayoutViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface LayoutViewController ()

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    //创建RedView
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:redView];
    
    //创建redView第一个约束，相对self.view的左边缘间距20
    NSLayoutConstraint * redLeftLc = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:20.0];
    [self.view addConstraint:redLeftLc];
    //创建redView第二个约束，相对self。view的底边缘间距20
    NSLayoutConstraint *redBottomLc = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-20];//由于是redview相对self.view往上减20，所以是-20
    //添加约束
    [self.view addConstraint:redBottomLc];
    
    NSLayoutConstraint *redHeight = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:50.0];
    [self.view addConstraint:redHeight];
    
    NSLayoutConstraint *redWidth = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:50.0];
    [self.view addConstraint:redWidth];
    
    //创建BlueView
    UIView *blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:blueView];
    
    //创建redView第一个约束，相对self.view的左边缘间距20
    NSLayoutConstraint * blueLeftLc = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:redView attribute:NSLayoutAttributeRight multiplier:1.0f constant:20.0];
    [self.view addConstraint:blueLeftLc];
    //创建redView第二个约束，相对self。view的底边缘间距20
    NSLayoutConstraint *blueBottomLc = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-20];//由于是redview相对self.view往上减20，所以是-20
    //添加约束
    [self.view addConstraint:blueBottomLc];
    NSLayoutConstraint *blueHeight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:50.0];
    [self.view addConstraint:blueHeight];
    
    NSLayoutConstraint *blueWidth = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:50.0];
    [self.view addConstraint:blueWidth];
    
    // 创建YellowView
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    yellowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:yellowView];
    
    //创建redView第一个约束，相对self.view的左边缘间距20
    NSLayoutConstraint * yellowCenterX = [NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    [self.view addConstraint:yellowCenterX];
    //创建redView第二个约束，相对self。view的底边缘间距20
    NSLayoutConstraint *yellowCenterY = [NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];//由于是redview相对self.view往上减20，所以是-20
    //添加约束
    [self.view addConstraint:yellowCenterY];
    NSLayoutConstraint *yellowHeight = [NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:50.0];
    [self.view addConstraint:yellowHeight];
    
    NSLayoutConstraint *yellowWidth = [NSLayoutConstraint constraintWithItem:yellowView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0f constant:50.0];
    [self.view addConstraint:yellowWidth];
    
    // Masonry 布局， 非常方便！
    UIView *orangeView = [[UIView alloc]init];
    [orangeView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:orangeView];
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.view).with.offset(-20);
        make.bottom.equalTo(self.view).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"second"]];
    [self.view addSubview:imageView];
    UILabel *textLabel = [[UILabel alloc] init];
    [textLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
    textLabel.text = @"看看看看看，有个人在布局， 有个人在布局，有个人在布局";
    [self.view addSubview:textLabel];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(10);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.left.mas_equalTo(imageView.mas_right);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(textLabel);
        make.right.mas_equalTo(textLabel.mas_left);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
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
