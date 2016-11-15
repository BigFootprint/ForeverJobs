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

@interface NetworkViewController ()
@property(nonatomic, strong) dispatch_queue_t networkQueue;
@property(nonatomic, strong) dispatch_queue_t mainQueue;
-(void)senRequest:(id)button;
@end

@implementation NetworkViewController

@synthesize responseLable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    UIButton *networkButton = [[UIButton alloc] init];
    [networkButton setBackgroundColor:[UIColor blackColor]];
    [networkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [networkButton setTitle:@"发送请求" forState:UIControlStateNormal];
    [networkButton setTitleColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [networkButton addTarget:self action:@selector(senRequest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:networkButton];
    
    responseLable = [[UILabel alloc] init];
    responseLable.backgroundColor = [UIColor whiteColor];
    responseLable.textColor = [UIColor blackColor];
    responseLable.numberOfLines = 0;
    [self.view addSubview:responseLable];
    
    [networkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(40);
    }];
    [responseLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
        make.top.mas_equalTo(networkButton.mas_bottom).offset(10);
    }];
    
    _networkQueue = dispatch_queue_create("com.footprint.MyP.Network", DISPATCH_QUEUE_CONCURRENT);
    _mainQueue = dispatch_get_main_queue();
}

-(void)senRequest:(id)button{
    responseLable.text = @"请求中...";
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
