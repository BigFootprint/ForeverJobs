//
//  HyiNormalNewsCell.m
//  MyP
//
//  Created by 李全民 on 16/12/30.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNormalNewsCell.h"
#import "HyiNews.h"
#import "HyiColor.h"
#import "HyiSize.h"
#import "Masonry.h"

@interface HyiNormalNewsCell ()
@property(nonatomic) UIImageView *newsImage;
@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UILabel *newsChannelLabel;
@property(nonatomic) UIButton *commentButton;
@property(nonatomic) UILabel *tipLabel;
@end

@implementation HyiNormalNewsCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"HyiNormalNewsCell";
    HyiNormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HyiNormalNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newsImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 100, 75)];
        self.newsImage.contentMode = UIViewContentModeScaleAspectFill;
        self.newsImage.clipsToBounds = YES;
        [self.newsImage setImage:[UIImage imageNamed:@"ty_a.jpg"]];
        [self.contentView addSubview:self.newsImage];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:LIST_TITLE_SIZE];
        self.titleLabel.textColor = TEXT_BLACK;
        self.titleLabel.numberOfLines = 2;
        [self.contentView addSubview:self.titleLabel];
        
        self.newsChannelLabel = [[UILabel alloc] init];
        self.newsChannelLabel.font = [UIFont fontWithName:@"Arial" size:12];
        self.newsChannelLabel.textColor = TEXT_LIGHT_GRAY;
        [self.contentView addSubview:self.newsChannelLabel];
        
        self.commentButton = [[UIButton alloc] init];
        self.commentButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.commentButton setTitleColor:TEXT_GRAY forState:UIControlStateNormal];
        [self.commentButton setBackgroundImage:[UIImage imageNamed:@"contentcell_comment_background"] forState:UIControlStateNormal];
        // TODO-待整理
        // 此处不要用 setTitleEdgeInsets，会导致 ... 的问题
        [self.commentButton setContentEdgeInsets:UIEdgeInsetsMake(3, 5, 3, 5)];
        [self.contentView addSubview:self.commentButton];
        
    }
    return self;
}

// tell UIKit that you are using AutoLayout
// From https://github.com/SnapKit/Masonry
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

-(void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.newsImage.mas_right).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.top.mas_equalTo(self.contentView.mas_top).offset(12);
        make.height.mas_equalTo(42);
    }];
    
    [self.newsChannelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.newsImage.mas_right).offset(15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-12);
    }];
    
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-12);
    }];
    
    [super updateConstraints];
}

-(void)refreshData:(HyiNews *)news{
    if(news.newsType != HyiNewsNormal)
        return;
    
    HyiNormalNews *normalNews = (HyiNormalNews *)news;
    self.titleLabel.text = normalNews.newsTitle;
    self.newsChannelLabel.text = normalNews.channel;
    [self.commentButton setTitle:[NSString stringWithFormat:@"%d跟帖", normalNews.commentCount] forState:UIControlStateNormal];
    [self.commentButton sizeToFit];
}

-(int)getCellHeight {
    return 94;
}
@end
