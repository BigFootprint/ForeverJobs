//
//  UIImageViewViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/11.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIImageViewViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface UIImageViewViewController ()
-(void)tapImageView:(id)sender;
@end

@implementation UIImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:ANDROID_BLUE];

    // 普通显示，图片压缩拉伸填满 ImageView
    UIImageView *imageViewA = [[UIImageView alloc] init];
    [imageViewA setImage:[UIImage imageNamed:@"monkey.jpg"]];
    imageViewA.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
    [imageViewA addGestureRecognizer:singleTap];
    
    [self.view addSubview:imageViewA];
    
    [imageViewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(80);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5f).offset(-15);
        make.height.mas_equalTo(imageViewA.mas_width);
    }];
    
    UIImageView *imageViewB = [[UIImageView alloc] init];
    [imageViewB setImage:[UIImage imageNamed:@"monkey.jpg"]];
    [self.view addSubview:imageViewB];
    
    // 圆角
    imageViewB.layer.masksToBounds = YES;
    imageViewB.layer.cornerRadius = 10;
    
    // 边框
    imageViewB.layer.borderColor = [UIColor orangeColor].CGColor;
    imageViewB.layer.borderWidth = 2;
    
    [imageViewB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(80);
        make.left.equalTo(imageViewA.mas_right).offset(10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5f).offset(-15);
        make.height.mas_equalTo(imageViewA.mas_width);
    }];
    
    // 缩放
    UIImageView *imageViewC = [[UIImageView alloc] init];
    [imageViewC setImage:[UIImage imageNamed:@"monkey.jpg"]];
    [imageViewC setBackgroundColor:[UIColor blackColor]];
    imageViewC.alpha = 0.5f;
    [self.view addSubview:imageViewC];
    [imageViewC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageViewA.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5f).offset(-15);
        make.height.mas_equalTo(imageViewC.mas_width);
    }];
    imageViewC.contentMode = UIViewContentModeScaleAspectFit;
    
    // 缩放
    UIImageView *imageViewD = [[UIImageView alloc] init];
    [imageViewD setImage:[UIImage imageNamed:@"monkey.jpg"]];
    [imageViewD setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:imageViewD];
    imageViewD.clipsToBounds = YES; // 不加就会超出边界
    [imageViewD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageViewB.mas_bottom).offset(10);
        make.left.equalTo(imageViewC.mas_right).offset(10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5f).offset(-15);
        make.height.mas_equalTo(imageViewD.mas_width);
    }];
    imageViewD.contentMode = UIViewContentModeScaleAspectFill;
    
    // 轮播
    UIImage *image1 = [UIImage imageNamed:@"monkey.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"settings"];
    NSArray *imagesArray = @[image1,image2];
    UIImageView *imageViewE = [[UIImageView alloc] init];
    imageViewE.animationImages = imagesArray;
    // 设定所有的图片在多少秒内播放完毕
    imageViewE.animationDuration = [imagesArray count];
    // 不重复播放多少遍，0表示无数遍
    imageViewE.animationRepeatCount = 0;
    [self.view addSubview:imageViewE];
    [imageViewE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageViewC.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(self.view.mas_width).multipliedBy(0.5f).offset(-15);
        make.height.mas_equalTo(imageViewE.mas_width);
    }];
    imageViewE.contentMode = UIViewContentModeScaleAspectFit;
    // 开始播放
    [imageViewE startAnimating];
}

-(void)tapImageView:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"UIImageView学习" message:@"你点击了我！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
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
