//
//  HyiNormalNewsCell.m
//  MyP
//
//  Created by 李全民 on 16/12/30.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiNormalNewsCell.h"
#import "Masonry.h"
#import "HyiNews.h"

@interface HyiNormalNewsCell ()
@property(nonatomic) UIImageView *newsImage;
@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UILabel *newsChannelLabel;
@property(nonatomic) UILabel *commentLabel;
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
        self.newsImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 10, 100, 75)];
        [self.newsImage setImage:[UIImage imageNamed:@"monkey.jpg"]];
        [self.contentView addSubview:self.newsImage];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.newsImage.mas_right).offset(15);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.top.mas_equalTo(self.contentView.mas_top).offset(12);
            make.height.mas_equalTo(42);
        }];
        
        self.newsChannelLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.newsChannelLabel];
        [self.newsChannelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.newsImage.mas_right).offset(15);
            make.bottom.mas_equalTo(self.newsImage.mas_bottom).offset(-12);
        }];
    }
    return self;
}

-(void)refreshData:(HyiNews *)news{
    if(news.newsType != HyiNewsNormal)
        return;
    
    HyiNormalNews *normalNews = (HyiNormalNews *)news;
    self.titleLabel.text = normalNews.newsTitle;
    self.newsChannelLabel.text = normalNews.newsTitle;
}

-(int)getCellHeight {
    return 89;
}
@end
