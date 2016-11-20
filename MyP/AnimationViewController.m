//
//  AnimationViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/20.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "AnimationViewController.h"
#import "Masonry.h"
#import "JobsConstants.h"

@interface AnimationViewController ()
-(void)startUIKitAnimation;
-(void)startCoreAnimation;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    UIButton *uiKitAnimation = [[UIButton alloc] init];
    [uiKitAnimation setBackgroundColor:[UIColor blackColor]];
    [uiKitAnimation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [uiKitAnimation setTitle:@"UIKit" forState:UIControlStateNormal];
    [uiKitAnimation setTitleColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [uiKitAnimation addTarget:self action:@selector(startUIKitAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:uiKitAnimation];
    
    UIButton *coreAnimation = [[UIButton alloc] init];
    [coreAnimation setBackgroundColor:[UIColor blackColor]];
    [coreAnimation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [coreAnimation setTitle:@"CoreAnimation" forState:UIControlStateNormal];
    [coreAnimation setTitleColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [coreAnimation addTarget:self action:@selector(startCoreAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:coreAnimation];
    
    self.animatedView = [[UIView alloc] init];
    [self.animatedView setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:self.animatedView];
    
    [self.animatedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.view.mas_left);
        make.top.mas_equalTo(uiKitAnimation.mas_top).offset(80);
    }];
    
    [uiKitAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(-5);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(40);
    }];
    
    [coreAnimation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(uiKitAnimation.mas_right).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right);
    }];
}

-(void)startUIKitAnimation{
    [UIView animateWithDuration:3 //时长
                          delay:0 //延迟时间
                        options:UIViewAnimationOptionAutoreverse//动画效果
                     animations:^{
                         //动画设置区域
                         _animatedView.backgroundColor=[UIColor blueColor];
                         _animatedView.frame=CGRectMake(100, 100, 200, 200);
                         _animatedView.alpha=0.5;
                         
                     } completion:^(BOOL finish){
                         //动画结束时调用
                         //............
                     }];
}

-(void)startCoreAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"backgroundColor"];
    //设置属性值, backgroundcolor一定要是CGColor的
    animation.values = [NSArray arrayWithObjects:
                      (id)_animatedView.backgroundColor.CGColor,// 去掉CGColor就会挂
                      (id)[UIColor yellowColor].CGColor,
                      (id)[UIColor greenColor].CGColor,
                      (id)[UIColor blueColor].CGColor,nil];
    animation.duration = 3;
    animation.autoreverses = YES;
    //把关键帧添加到layer中
    [self.animatedView.layer addAnimation:animation forKey:@"backgroundColor"];
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
