//
//  AppDelegate.m
//  MyP
//
//  Created by 李全民 on 16/11/8.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "AppDelegate.h"
#import "TrainningViewController.h"
#import "OnePieceViewController.h"
#import "ActionViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    UIScreen *screen = [UIScreen mainScreen];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[screen bounds]];
    
    UIViewController *trainningController = [[TrainningViewController alloc] init];
    trainningController.tabBarItem.title = @"训练营";
    trainningController.view.backgroundColor = [UIColor whiteColor];
    trainningController.tabBarItem.image = [UIImage imageNamed:@"home"];
    
    UIViewController *onepieceController = [[OnePieceViewController alloc] init];
    onepieceController.tabBarItem.title = @"One Piece";
    onepieceController.tabBarItem.badgeValue = @"New";
    onepieceController.tabBarItem.image = [UIImage imageNamed:@"onepiece"];
    
    UIViewController *actionController = [[ActionViewController alloc] init];
    actionController.tabBarItem.title = @"练手";
    actionController.tabBarItem.image = [UIImage imageNamed:@"settings"];
    
    tabBarController.viewControllers = @[trainningController, onepieceController, actionController];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    //rootNav.navigationBar.barTintColor = [UIColor redColor];
    
    self.window = window;
    window.rootViewController = rootNav;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
}

@end
