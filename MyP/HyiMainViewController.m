//
//  HyiViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/27.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiMainViewController.h"
#import "NewsViewController.h"
#import "LiveViewController.h"
#import "TopicViewController.h"
#import "SelfViewController.h"
#import "Masonry.h"
#import "Color.h"

@interface HyiMainViewController ()

@end

@implementation HyiMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabBar];
}

-(void)initTabBar {
    UIViewController *newsController = [[NewsViewController alloc] init];
    newsController.tabBarItem.title = @"新闻";
    newsController.view.backgroundColor = [UIColor whiteColor];
    newsController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_news_normal"];
    // 接口设计不一致
    newsController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_news_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *liveController = [[LiveViewController alloc] init];
    liveController.tabBarItem.title = @"直播";
    liveController.view.backgroundColor = [UIColor whiteColor];
    liveController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_media_normal"];
    liveController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_media_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *topicController = [[TopicViewController alloc] init];
    topicController.tabBarItem.title = @"话题";
    topicController.view.backgroundColor = [UIColor whiteColor];
    topicController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_found_normal"];
    topicController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_found_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *selfController = [[SelfViewController alloc] init];
    selfController.tabBarItem.title = @"我";
    selfController.view.backgroundColor = [UIColor whiteColor];
    selfController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_me_normal"];
    selfController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_me_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[newsController, liveController, topicController, selfController];
    // 这种更改方式会导致整个 App 的 Title 字体颜色变化，iOS这个设计真是没sei了
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HYI_RED} forState:UIControlStateSelected];
    [[UINavigationBar appearance] setBarTintColor:HYI_RED];
}

- (void)viewDidLayoutSubviews {
    
}
@end
