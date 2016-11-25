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
 WKNavigationDelegate 控制 & 监控加载过程
 WKUIDelegate UI相关，包括输入框、警告框等，没有实现这个协议，弹框无效
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

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title = @"One Piece";
}

-(void)configureWebView{
    // js配置
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    /* 多个消息体可以对应一个Handler, 这些消息会在userContentController，也就是实现了 WKScriptMessageHandler 协议的对象中被接收到 */
    [userContentController addScriptMessageHandler:self name:@"MyP_jsCallOC"];
    [userContentController addScriptMessageHandler:self name:@"MyP_jsCallOC_2"];
    
    // TODO 注入JS(现在不运行)
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:@"ocCall(\"加载完毕\")" injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [userContentController addUserScript:userScript];
    
    // WKWebView的配置
    WKWebViewConfiguration *cf = [[WKWebViewConfiguration alloc] init];
    cf.userContentController = userContentController;
    cf.preferences.javaScriptEnabled = YES;
    cf.preferences.minimumFontSize = 18;
    
    // 实例化
    webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds] configuration:cf];
    webView.navigationDelegate = self;
    webView.UIDelegate = self;
}

#pragma mark - WKNavigationDelegate
/* URL打开前拦截 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@", [[navigationAction.request URL] description]);
    // 允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
}

/* 页面开始加载 */
- (void)webView:(WKWebView *)wv didStartProvisionalNavigation:(WKNavigation *)navigation{
    //并没有什么卵用啊，拿不到信息
    NSString *url = wv.URL.absoluteString;
    NSLog(@"加载开始: %@", url);
}

/* 开始获取到网页内容时 */
- (void)webView:(WKWebView *)wv didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"开始获取到内容");
}

/* 页面加载完成之后调用 */
- (void)webView:(WKWebView *)wv didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"加载完成");
}

/* 页面加载失败时调用 */
- (void)webView:(WKWebView *)wv didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败");
}

#pragma mark - WKScriptMessageHandler
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

#pragma mark - WKUIDelegate
#pragma mark 关闭webView
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark alert弹出框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    // 确定按钮
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Confirm选择框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    // 按钮
    UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户选择的信息
        completionHandler(NO);
    }];
    UIAlertAction *alertActionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertActionCancel];
    [alertController addAction:alertActionOK];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark TextInput输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(nonnull NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(NSString * _Nullable))completionHandler {
    NSLog(@"%s",__FUNCTION__);
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = defaultText;
    }];
    // 确定按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户输入的信息
        UITextField *textField = alertController.textFields.firstObject;
        completionHandler(textField.text);
    }]];
    // 显示
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
