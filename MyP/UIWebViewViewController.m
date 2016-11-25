//
//  UIWebViewViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/25.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIWebViewViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface UIWebViewViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@end

@implementation UIWebViewViewController
@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"webviewstudy" withExtension:@"html"];
    NSURLRequest *nsURLRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:nsURLRequest];
   
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.top.mas_equalTo(self.view.mas_top);
    }];
}

- (BOOL)webView:(UIWebView *)wv shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlStr = request.URL.absoluteString;
    NSLog(@"加载前：%@", urlStr);
    
    if([request.URL.scheme isEqualToString:@"myp"]){
        NSLog(@"收到JS本地方法调用：%@", urlStr);
        [wv stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"ocCall(\"Native收到: %@\");", urlStr]];
        return NO;
    }
    
    return YES;//YES表示继续加载，NO表示不加载
}
- (void)webViewDidStartLoad:(UIWebView *)wv{
    NSLog(@"加载开始");
}
- (void)webViewDidFinishLoad:(UIWebView *)wv{
    NSLog(@"加载完成");
}
- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败：%@", [error localizedDescription]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
