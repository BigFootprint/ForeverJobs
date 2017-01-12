//
//  UILabelViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/11.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UILabelViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface UILabelViewController ()

@end

@implementation UILabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    UILabel *testLabelA = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
    testLabelA.font = [UIFont fontWithName:@"Arial" size:20];
    testLabelA.text = @"居中";
    testLabelA.textAlignment = NSTextAlignmentCenter;
    testLabelA.textColor = [UIColor whiteColor];
    testLabelA.backgroundColor = [UIColor blackColor];
    testLabelA.center = CGPointMake(screenSize.width/2, screenSize.height/2 - 80 * 3);
    
    UILabel *testLabelB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
    testLabelB.font = [UIFont fontWithName:@"Arial" size:20];
    testLabelB.text = @"超长字符，省略，超长字符，超长字符，超长字符";
    testLabelB.textColor = [UIColor whiteColor];
    testLabelB.backgroundColor = [UIColor blackColor];
    testLabelB.center = CGPointMake(screenSize.width/2, screenSize.height/2 - 80 * 2);
    
    UILabel *testLabelC = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 70)];
    testLabelC.font = [UIFont fontWithName:@"Arial" size:20];
    testLabelC.text = @"换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行";
    testLabelC.numberOfLines = 0;
    testLabelC.textColor = [UIColor whiteColor];
    testLabelC.backgroundColor = [UIColor blackColor];
    testLabelC.center = CGPointMake(screenSize.width/2, screenSize.height/2 - 80);
    
    // 计算需要显示的高度
    UILabel *testLabelD = [[UILabel alloc] init];
    int width = 200;
    UIFont *font = [UIFont fontWithName:@"Arial" size:20];
    NSString *content = @"计算需要显示的高度计算需要显示的高度计算需要显示的高度计算需要显示的高度计算需要显示的高度计算需要显示的高度计算需要显示的高度";
    testLabelD.font = font;
    testLabelD.text = content;
    CGSize titleSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    testLabelD.numberOfLines = 0;
    testLabelD.textColor = [UIColor whiteColor];
    testLabelD.backgroundColor = [UIColor blackColor];
    testLabelD.frame = CGRectMake(0, testLabelC.center.y + 40, titleSize.width, titleSize.height);
    
    UILabel *testLabelE = [[UILabel alloc] init];
    testLabelE.font = [UIFont fontWithName:@"Arial" size:20];
    testLabelE.text = @"换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行换行";
    testLabelE.numberOfLines = 1;
    testLabelE.textColor = [UIColor whiteColor];
    testLabelE.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:testLabelA];
    [self.view addSubview:testLabelB];
    [self.view addSubview:testLabelC];
    [self.view addSubview:testLabelD];
    [self.view addSubview:testLabelE];
    
    [testLabelE mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.mas_equalTo(testLabelD.mas_bottom).offset(10);
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
