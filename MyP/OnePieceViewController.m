//
//  SecondViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/8.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "OnePieceViewController.h"
#import <WebKit/WebKit.h>
#import "JobsConstants.h"
#import "Masonry.h"

/**
 WKScriptMessageHandler 接收来自 WebView JS消息
 
 */
@interface OnePieceViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property(nonatomic, strong) WKWebView *webView;

-(void)configureWebView;
@end

@implementation OnePieceViewController
@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 实例化WebView
    [self configureWebView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"onepiece" withExtension:@"html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

-(void)configureWebView{
    // js配置
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    /* 多个消息体可以对应一个Handler, 这些消息会在userContentController，也就是实现了 WKScriptMessageHandler 协议的对象中被接收到 */
    [userContentController addScriptMessageHandler:self name:@"MyP_jsCallOC"];
    [userContentController addScriptMessageHandler:self name:@"MyP_jsCallOC_2"];
    
    // TODO 注入JS(现在不运行)
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"alert(\"Native收到！\");" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userContentController addUserScript:userScript];
    
    // WKWebView的配置
    WKWebViewConfiguration *cf = [[WKWebViewConfiguration alloc] init];
    cf.userContentController = userContentController;
    cf.preferences.javaScriptEnabled = YES;
    cf.preferences.minimumFontSize = 18;
    
    // 实例化
    webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds] configuration:cf];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title = @"One Piece";
}

/*
 通过添加到将该协议添加到 WKUserContentController，可以向WebView注册消息处理对象
 
 ! @abstract Invoked when a script message is received from a webpage.
 @param userContentController The user content controller invoking the
 delegate method.  注册的时候使用的userContentController
 @param message The script message received.  H5通过 postMessage 发出的消息体
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    NSLog(@"方法名: %@", message.name);
    NSLog(@"参数: %@", message.body);
    
    // 同样这里可以通过userContentController来添加更多的可调用方法
    
    // 注入JS
    [webView evaluateJavaScript:@"ocCall(\"Native收到\")" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        if(error == nil){
            NSLog(@"已经回调JS");
        }else{
            NSLog(@"回调错误：%@", [error localizedDescription]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
