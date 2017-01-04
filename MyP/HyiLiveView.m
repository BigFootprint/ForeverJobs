//
//  HyiLiveView.m
//  MyP
//
//  Created by 李全民 on 16/12/30.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiLiveView.h"
#import "HyiColor.h"

@interface HyiLiveView ()
@property(nonatomic, strong) UIImageView *liveView;
@property(nonatomic, strong) UILabel *liveCountLabel;
@end

@implementation HyiLiveView
@synthesize liveView;
@synthesize liveCountLabel;

-(instancetype)init {
    CGRect frame = CGRectMake(0, 0, 32, 22);
    self = [super initWithFrame:frame];
    if(self){
        [self buildView];
    }
    
    return self;
}

-(void)buildView {
    liveView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 22)];
    
    NSMutableArray *images = [NSMutableArray array];// 加载所有的动画图片
    [images addObject:[UIImage imageNamed:@"nav_live_room_rolling_first"]];
    [images addObject:[UIImage imageNamed:@"nav_live_room_rolling_third"]];
    [images addObject:[UIImage imageNamed:@"nav_live_room_rolling_second"]];
    
    liveView.animationImages = images;// 设置动画图片
    liveView.animationRepeatCount = 3;// 设置播放次数
    liveView.image = [UIImage imageNamed:@"nav_live_room_image"];// 设置图片
    liveView.animationDuration = 0.3;// 设置动画的时间
    liveView.backgroundColor = TRANSPARENT;
    
    liveCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(-8, 6, 10, 22)];
    liveCountLabel.textAlignment = NSTextAlignmentCenter;
    liveCountLabel.font = [UIFont fontWithName:@"Arial" size:10];// 网易的字体不是这个
    liveCountLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:liveView];
    [self addSubview:liveCountLabel];
}

-(void)doAnimation {
    [liveView startAnimating];
    
    // TODO-待调整
    // 动画整理 & 优化，争取逼近网易效果
    // Label 动画
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-5];
    shake.toValue = [NSNumber numberWithFloat:3];
    shake.autoreverses = YES; //是否重复
    shake.duration = 0.1;
    shake.repeatCount = 2;//次数
    [liveCountLabel.layer addAnimation:shake forKey:@"shakeAnimation"];
    [UIView animateWithDuration:0.5 delay:0.3 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{

    } completion:nil];
}

-(void)setCount:(int)count {
    liveCountLabel.text = [NSString stringWithFormat:@"%d", count];
    [liveCountLabel sizeToFit];
}
@end
