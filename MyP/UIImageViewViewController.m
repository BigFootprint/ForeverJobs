//
//  UIImageViewViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/11.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIImageViewViewController.h"
#import "JobsConstants.h"

@interface UIImageViewViewController ()

@end

@implementation UIImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:ANDROID_BLUE];
    // 图片读取
    //初始化
    // UIImageView  *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(100, 200, 120, 120)];
    //第一种：
    //[imageView setImage:[UIImage imageNamed:@"1.jpeg"]];
    
    //第二种：
    //NSString *filePath=[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpeg"];
    //UIImage *images=[UIImage imageWithContentsOfFile:filePath];
    //[imageView setImage:images];
    
    //第三种：
    //NSData *data=[NSData dataWithContentsOfFile:filePath];
    //UIImage *image2=[UIImage imageWithData:data];
    //[imageView setImage:image2];
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
