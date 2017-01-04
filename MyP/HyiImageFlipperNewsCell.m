//
//  HyiImageFlipperNewsCell.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiImageFlipperNewsCell.h"
#import "HyiMultiPageScrollView.h"
#import "HyiMultiPageScrollViewDataSource.h"
#import "HyiMultiPageScrollViewDataDelegate.h"
#import "HyiNews.h"
#import "HyiColor.h"
#import "HyiSize.h"
#import "Masonry.h"

@interface HyiImageFlipperNewsCell ()<HyiMultiPageScrollViewDataSource, HyiMultiPageScrollViewDataDelegate>
@property(nonatomic, strong) HyiMultiPageScrollView *hyiMultiPageScrollView;
@property(nonatomic, strong) UIView *barView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIPageControl *control;

@property(nonatomic, strong) HyiImageFlipperNews *dataNews;
@end

@implementation HyiImageFlipperNewsCell
@synthesize hyiMultiPageScrollView;
@synthesize barView;
@synthesize titleLabel;
@synthesize control;

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"HyiImageFlipperNewsCell";
    HyiImageFlipperNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HyiImageFlipperNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.barView.backgroundColor = TRANSPARENT_BLACK;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.hyiMultiPageScrollView = [[HyiMultiPageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self getCellHeight])];
        [self.contentView addSubview:self.hyiMultiPageScrollView];
        
        self.barView = [[UIView alloc] init];
        self.barView.backgroundColor = TRANSPARENT_BLACK;
        [self.contentView addSubview:self.barView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        self.titleLabel.numberOfLines = 1;
        [self.barView addSubview:titleLabel];
        
        self.control = [[UIPageControl alloc] init];
        [self.barView addSubview:control];
    }
    return self;
}

-(void)updateConstraints {
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.contentView.mas_top).offset([self getCellHeight] - 30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.barView.mas_left).offset(10);
        make.top.mas_equalTo(self.barView.mas_top).offset(7.5f);
    }];
    
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.barView.mas_right).offset(-10);
        make.top.mas_equalTo(self.barView.mas_top);
    }];
    
    [super updateConstraints];
}

// 更新数据
-(void)refreshData:(HyiNews *)news {
    if(news.newsType != HyiNewsImageFlipper)
        return;
    
    HyiImageFlipperNews *imageFlipperNews = (HyiImageFlipperNews *)news;
    self.titleLabel.text = imageFlipperNews.newsTitle;
    self.control.numberOfPages = [imageFlipperNews.imageArr count];
    
    self.dataNews = imageFlipperNews;
    self.hyiMultiPageScrollView.hyiDelegate = self;
    self.hyiMultiPageScrollView.hyiDataSource = self;
}

// 返回行高
-(int)getCellHeight {
    return 185; // 实际可以根据比例 和 屏幕宽度得到高度
}

#pragma mark - HyiMultiPageScrollViewDataSource
-(int)getPageCount {
    return (int)[self.dataNews.imageArr count];
}

// 根据 Tag 获取 View
-(UIView *)getPageViewByTag:(NSString *)tag {
    // TODO-待整理
    // iOS 中的变量名务必注意，很容易和原生组件的变量名重复，因此必须足够独特
    UIImageView *flipperImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self getCellHeight])];
    // 实际从网上拉取
    [flipperImageView setImage:[UIImage imageNamed:tag]];
    flipperImageView.contentMode = UIViewContentModeScaleAspectFill;
    flipperImageView.clipsToBounds = YES;
    return flipperImageView;
}

// 为页面设置一个Tag，目的是为了可以任意插入新的 View
-(NSString *)getPageTagAtIndex:(int)index {
    return [self.dataNews.imageArr objectAtIndex:index];
}

#pragma mark - HyiMultiPageScrollViewDataDelegate
-(void)select:(int)index withView:(UIView *)view {
    [control setCurrentPage:index];
}
@end
