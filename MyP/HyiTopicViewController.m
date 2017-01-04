//
//  TopicViewController.m
//  MyP
//
//  Created by 李全民 on 16/12/28.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiTopicViewController.h"

@interface HyiTopicViewController ()
@property(nonatomic, strong) UIBarButtonItem *leftItem;
@property(nonatomic, strong) UIBarButtonItem *rightItem;
@end

@implementation HyiTopicViewController
@synthesize leftItem;
@synthesize rightItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark Navigator

-(void)initNavigationBar {
    [self initLeftView];
    [self initCenterView];
    [self initRightView];
}

- (void)initLeftView {
    if(leftItem == nil) {
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [leftButton setImage:[UIImage imageNamed:@"qa_login_normal"] forState:UIControlStateNormal];
        leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    }
    
    self.tabBarController.navigationItem.leftBarButtonItem = leftItem;
}

-(void)initCenterView {
    
}

-(void)initRightView {
    if(rightItem == nil) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [rightButton setImage:[UIImage imageNamed:@"subj_search_icon"] forState:UIControlStateNormal];
        rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
    
    self.tabBarController.navigationItem.rightBarButtonItem = rightItem;
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
