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

@interface HyiNewsTableView ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic) NSArray<HyiNews *> *dataArr;
@end

@implementation HyiNewsTableView
@synthesize hyiNewsDataSource;
@synthesize dataArr;

-(instancetype)init{
    self = [super init];
    if(self){
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.dataSource = self;
        self.delegate =self;
    }
    return self;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(dataArr == nil)
        return 0;
    
    return [dataArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HyiNews *news = [dataArr objectAtIndex:[indexPath row]];
    UITableViewCell<HyiNewsCellDataSource> *cell = [HyiNewsCellFactory getCellForNewsType:news.newsType InTableView:self];
    if(cell){
        [cell refreshData:news];
        news.cellHeight = [cell getCellHeight];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HyiNews *news = [dataArr objectAtIndex:[indexPath row]];
    return news.cellHeight;
}
@end
