//
//  SecondViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/8.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "OnePieceViewController.h"

@interface OnePieceViewController ()

@end

@implementation OnePieceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.scalesPageToFit = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title = @"One Piece";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
