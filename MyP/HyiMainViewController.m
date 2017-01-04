//
//  HyiViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/27.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiMainViewController.h"
#import "HyiNewsViewController.h"
#import "HyiLiveViewController.h"
#import "HyiTopicViewController.h"
#import "HyiSelfViewController.h"
#import "HyiColor.h"
#import "Masonry.h"

@interface HyiMainViewController ()

@end

@implementation HyiMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTabBar];
}

-(void)viewWillAppear:(BOOL)animated{
    // TODO-待整理
    // 如果把这句话移到 #viewDidLoad 方法就不生效，self.navigationController 会为 Nil，
    // 此时 Controller 还没被添加到 NaviController 中去
    self.navigationController.navigationBar.barTintColor = HYI_RED;
    self.navigationController.navigationBar.translucent = NO;
    [[self selectedViewController] viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    // 解决一个Bug：子View收不到 viewDidAppear 消息
    [[self selectedViewController] viewDidAppear:animated];
}

-(void)initTabBar {
    UIViewController *newsController = [[HyiNewsViewController alloc] init];
    newsController.tabBarItem.title = @"新闻";
    newsController.view.backgroundColor = [UIColor whiteColor];
    newsController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_news_normal"];
    // 接口设计不一致
    newsController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_news_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *liveController = [[HyiLiveViewController alloc] init];
    liveController.tabBarItem.title = @"直播";
    liveController.view.backgroundColor = [UIColor whiteColor];
    liveController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_media_normal"];
    liveController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_media_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *topicController = [[HyiTopicViewController alloc] init];
    topicController.tabBarItem.title = @"话题";
    topicController.view.backgroundColor = [UIColor whiteColor];
    topicController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_bar_normal"];
    topicController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_bar_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIViewController *selfController = [[HyiSelfViewController alloc] init];
    selfController.tabBarItem.title = @"我";
    selfController.view.backgroundColor = [UIColor whiteColor];
    selfController.tabBarItem.image = [UIImage imageNamed:@"tabbar_icon_me_normal"];
    selfController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_icon_me_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[newsController, liveController, topicController, selfController];
    // TODO-待整理
    // 这种更改方式会导致整个 App 的 Title 字体颜色变化，iOS这个设计真是没sei了
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:HYI_RED} forState:UIControlStateSelected];
}
@end
