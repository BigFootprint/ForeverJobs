//
//  FirstViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/8.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "TrainningViewController.h"
#import "JobsConstants.h"

@interface TrainningViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<NSString *> *> *data;
@property (nonatomic, strong) NSArray<NSString *> *dataGroup;

-(void)initView;
-(NSArray *)getKnowledgeArray;
+(int)getStatusHeight;
@end

@implementation TrainningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _data = [self getKnowledgeArray];
    _dataGroup = [self getKnowledgeGroup];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationItem.title = @"训练营";
}

-(void)initView {
    // 添加 ScrollView
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height - 49)];

    [_tableView setDataSource:self];
    _tableView.delegate = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0); // 设置端距，这里表示separator离左边和右边均80像素
    [self.view addSubview:_tableView];
}

#pragma mark - 数据源方法
#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _data[section];
    return array.count;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text=_data[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark 返回每组头标题名称
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _dataGroup[section];
}

#pragma mark 设置分组标题内容高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    // create the button object
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.backgroundColor = ANDROID_BLUE;
    headerLabel.layer.cornerRadius = 5;
    headerLabel.highlightedTextColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:20];
    headerLabel.frame = CGRectMake(0, 0, screenSize.height, 40);
    
    NSString *headerText = [[NSString alloc]initWithFormat:@"%@  %@  %@", @"》> = -", _dataGroup[section], @"- = <《"];
    [headerLabel setText:headerText];
    return headerLabel;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content = _data[indexPath.section][indexPath.row];
    NSLog(@"%@", _data[indexPath.section][indexPath.row]);
    NSString *controllerName = [[NSString alloc] initWithFormat:@"%@%@", content, @"ViewController"];
    Class cls = NSClassFromString(controllerName);
    if(cls){
        UIViewController *buttonVc = [cls new];
        buttonVc.title = [[NSString alloc] initWithFormat:@"%@%@", content, @"·学习"];
        [self.tabBarController.navigationController pushViewController:buttonVc animated:YES];
    }
}

+(int)getStatusHeight{
CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    return rectStatus.size.height;
}

-(NSArray *)getKnowledgeArray{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSMutableDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [plistData objectForKey:@"knowledge"];
}

-(NSArray *)getKnowledgeGroup{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSMutableDictionary *plistData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return [plistData objectForKey:@"knowledgegroup"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
