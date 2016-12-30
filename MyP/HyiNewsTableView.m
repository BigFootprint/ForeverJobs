//
//  HyiNewsTableView.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNewsTableView.h"
#import "HyiNews.h"
#import "HyiNewsCellFactory.h"
#import "HyiNewsCellDataSource.h"
#import "HyiNewsDataSource.h"
#import "MJRefresh.h"

@interface HyiNewsTableView ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic) NSArray<HyiNews *> *dataArr;
@end

@implementation HyiNewsTableView
@synthesize hyiNewsDataSource;
@synthesize dataArr;

-(instancetype)init{
    self = [super init];
    if(self){
        [self initExtraParams];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [self initExtraParams];
    }
    return self;
}

-(void)initExtraParams {
    self.dataSource = self;
    self.delegate =self;
    
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [weakSelf refreshData];
    }];
}

-(void)loadMoreData {
    if(hyiNewsDataSource){
        [hyiNewsDataSource loadMoreData:^(NSArray<HyiNews *> *data) {
            dataArr = data;
            // 刷新数据
            [self reloadData];
        }];
    }
}

-(void)refreshData {
    if(hyiNewsDataSource){
        [hyiNewsDataSource refreshData:^(NSArray<HyiNews *> *data) {
            dataArr = data;
            // 刷新数据
            [self reloadData];
        }];
    }
}

# pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// #A
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(dataArr == nil)
        return 0;
    
    return [dataArr count];
}

// TODO-待整理
// 可以看一下 A 方法和这个方法的调用关系
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HyiNews *news = [dataArr objectAtIndex:[indexPath row]];
    UITableViewCell<HyiNewsCellDataSource> *cell = [HyiNewsCellFactory getCellForNewsType:news.newsType InTableView:self];
    if(cell){
        [cell refreshData:news];
        news.cellHeight = [cell getCellHeight];
    }
    return cell;
}

# pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HyiNews *news = [dataArr objectAtIndex:[indexPath row]];
    return news.cellHeight;
}
@end
