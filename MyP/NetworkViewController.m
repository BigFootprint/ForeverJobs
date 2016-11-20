//
//  NetworkViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/15.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import <libextobjc/extobjc.h>
#import "NetworkViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"
#import "AFNetworking.h"

@interface NetworkViewController ()
@property(nonatomic, strong) dispatch_queue_t networkQueue;
@property(nonatomic, strong) dispatch_queue_t mainQueue;
-(void)sendNSURLSessionRequest:(id)button;
-(void)sendAFNetworingRequest:(id)button;
@end

@implementation NetworkViewController

@synthesize responseLable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    UIButton *nSURLSessionNetworkButton = [[UIButton alloc] init];
    [nSURLSessionNetworkButton setBackgroundColor:[UIColor blackColor]];
    [nSURLSessionNetworkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nSURLSessionNetworkButton setTitle:@"NSURLSession" forState:UIControlStateNormal];
    [nSURLSessionNetworkButton setTitleColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [nSURLSessionNetworkButton addTarget:self action:@selector(sendNSURLSessionRequest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nSURLSessionNetworkButton];
    
    UIButton *aFNetworkingNetworkButton = [[UIButton alloc] init];
    [aFNetworkingNetworkButton setBackgroundColor:[UIColor blackColor]];
    [aFNetworkingNetworkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [aFNetworkingNetworkButton setTitle:@"AFNetworking" forState:UIControlStateNormal];
    [aFNetworkingNetworkButton setTitleColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [aFNetworkingNetworkButton addTarget:self action:@selector(sendAFNetworingRequest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aFNetworkingNetworkButton];
    
    responseLable = [[UILabel alloc] init];
    responseLable.backgroundColor = [UIColor whiteColor];
    responseLable.textColor = [UIColor blackColor];
    responseLable.numberOfLines = 0;
    [self.view addSubview:responseLable];
    
    [nSURLSessionNetworkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_centerX).offset(-5);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(40);
    }];
    
    [aFNetworkingNetworkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nSURLSessionNetworkButton.mas_right).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    [responseLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        make.top.mas_equalTo(nSURLSessionNetworkButton.mas_bottom).offset(10);
    }];
    
    _networkQueue = dispatch_queue_create("com.footprint.MyP.Network", DISPATCH_QUEUE_CONCURRENT);
    _mainQueue = dispatch_get_main_queue();
    
    // TODO AFNetworking
    
    // TODO CFNetwork
}

-(void)sendNSURLSessionRequest:(id)button{
    responseLable.text = @"NSURLSession 请求中...";
    dispatch_async(_networkQueue, ^{
        // 快捷方式获得session对象
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:@"http://httpbin.org/headers"];
        // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
        NSURLSessionTask *task = [session dataTaskWithURL:url
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            @weakify(self)
                                            dispatch_async(_mainQueue, ^{
                                                @strongify(self);
                                                NSString *response = [NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]];
                                                self.responseLable.text = response;
                                            });
                                        }];
        [task resume];
    });
}

-(void)sendAFNetworingRequest:(id)button{
    responseLable.text = @"AFNetworking 请求中...";
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *domainStr = @"http://httpbin.org/headers";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //以get的形式提交，只需要将上面的请求地址给GET做参数就可以
    [manager GET:domainStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //json解析
        NSString *response = [NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil]];
        self.responseLable.text = response;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 解析失败隐藏系统风火轮(可以打印error.userInfo查看错误信息)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
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
