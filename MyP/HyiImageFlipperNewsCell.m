//
//  HyiImageFlipperNewsCell.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiImageFlipperNewsCell.h"
#import "HyiNews.h"
#import "HyiColor.h"
#import "Masonry.h"

@interface HyiImageFlipperNewsCell ()
@property(nonatomic, strong) UIImageView *contentImageView;//待替换
@property(nonatomic, strong) UIView *barView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIPageControl *control;
@end

@implementation HyiImageFlipperNewsCell
@synthesize contentImageView;
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
        int screenWidth = [[UIScreen mainScreen] bounds].size.width;
        
        self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, [self getCellHeight])];
        self.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.contentImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.contentImageView];
        
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
    int screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.contentView.mas_top).offset([self getCellHeight] - 30);
        make.size.mas_equalTo(CGSizeMake(screenWidth, 30));
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.barView.mas_left).offset(10);
        make.top.mas_equalTo(self.barView.mas_top).offset(7.5f);
        make.size.mas_equalTo(CGSizeMake(screenWidth, 15));
    }];
    
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.barView.mas_right).offset(-10);
        make.top.mas_equalTo(self.barView.mas_top).offset(12);
    }];
    
    [super updateConstraints];
}

// 更新数据
-(void)refreshData:(HyiNews *)news {
    if(news.newsType != HyiNewsImageFlipper)
        return;
    
    HyiImageFlipperNews *imageFlipperNews = (HyiImageFlipperNews *)news;
    self.titleLabel.text = imageFlipperNews.newsTitle;
    [self.contentImageView setImage:[UIImage imageNamed:@"ty_d.jpg"]];
    
    control.numberOfPages = 2;
}

// 返回行高
-(int)getCellHeight {
    return 185; // 实际可以根据比例 和 屏幕宽度得到高度
}

@end
