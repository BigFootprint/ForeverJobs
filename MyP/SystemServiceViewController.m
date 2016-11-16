//
//  SystemServiceViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/16.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "SystemServiceViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface SystemServiceViewController ()
-(void)sendSms;
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body;
@end

@implementation SystemServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    UIButton *smsButton = [[UIButton alloc] init];
    [smsButton setTitle:@"发送短信" forState:UIControlStateNormal];
    [smsButton setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:smsButton];
    [smsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.width.mas_equalTo(self.view.mas_width);
    }];
    [smsButton addTarget:self action:@selector(sendSms) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sendSms{
    // 应用外发送
    // [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://13888888888"]];
    // 应用内发送
    [self showMessageView:[NSArray arrayWithObjects:@"15888888888",@"12399999999", nil] title:@"test" body:@"这是测试用短信，勿回复！"];
    // 打电话、发邮件也分为这两种
}

#pragma mark - 发送短信方法
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] ) { // 模拟器返回false
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    } else {
        NSLog(@"不支持短信发送");
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            NSLog(@"成功");
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            NSLog(@"失败");
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            NSLog(@"取消");
            break;
        default:
            break;
    }
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
