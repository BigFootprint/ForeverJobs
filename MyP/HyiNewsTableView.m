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

@interface HyiNewsTableView ()<UITableViewDataSource>
@property(nonatomic) NSArray<HyiNews *> *dataArr;
@end

@implementation HyiNewsTableView
@synthesize hyiNewsDataSource;
@synthesize dataArr;

-(instancetype)init{
    self = [super init];
    if(self){
        self.dataSource = self;
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
    }
    return cell;
}


@end
