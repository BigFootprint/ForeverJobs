//
//  FirstViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/8.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "TrainningViewController.h"
#import "UIButtonViewController.h"

@interface TrainningViewController ()
@property (nonatomic, strong) UITableView *tableView;
-(void)initView;
-(void)buttonClick;
-(NSArray *)getKnowledgeArray;
+(int)getStatusHeight;

@end

@implementation TrainningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
    NSLog(@"%@", @"Home-viewDidLoad");
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@", @"Home-viewWillAppear");
    self.tabBarController.navigationItem.title = @"训练营";
}

-(void)initView {
    int statusHeight = [TrainningViewController getStatusHeight];
    // 添加 ScrollView
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44 + statusHeight, screenSize.width, screenSize.height - 44 - 49 - statusHeight)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_sky"]];
    
    [_tableView setBackgroundView:imageView];
    [self.view addSubview:_tableView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    button.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonClick{
    UIButtonViewController *nextController = [[UIButtonViewController alloc] init];
    [self.tabBarController.navigationController pushViewController:nextController animated:YES];
}

+(int)getStatusHeight{
CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

-(NSArray *)getKnowledgeArray{
    return @[@"UIButton", @"UILabel", @"UIImageView", @"UITextField", @"UIAlertView", @"UILabel", @"UIImageView", @"UITextField", @"UIAlertView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"%@", @"Home-didReceiveMemoryWarning");
}

-(void)loadView{
    [super loadView];
    NSLog(@"%@", @"Home-loadView");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"%@", @"Home-viewWillDisappear");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"%@", @"Home-viewDidAppear");
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"%@", @"Home-viewWillLayoutSubviews");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"%@", @"Home-viewDidLayoutSubviews");
}
@end
