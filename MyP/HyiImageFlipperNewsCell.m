//
//  HyiImageFlipperNewsCell.m
//  MyP
//
//  Created by 李全民 on 16/12/29.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiImageFlipperNewsCell.h"
#import "HyiNews.h"
#import "Color.h"
#import "Masonry.h"

@interface HyiImageFlipperNewsCell ()
@property(nonatomic, strong) UIImageView *contentImageView;//待替换
@property(nonatomic, strong) UIView *barView;
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation HyiImageFlipperNewsCell
@synthesize contentImageView;
@synthesize barView;
@synthesize titleLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"HyiImageFlipperNewsCell";
    HyiImageFlipperNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HyiImageFlipperNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
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
        
        self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
        self.barView.backgroundColor = TRANSPARENT_BLACK;
        [self.contentView addSubview:self.barView];
        [barView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 30)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentCenter | NSTextAlignmentLeft;
        [barView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return self;
}

// 更新数据
-(void)refreshData:(HyiNews *)news {
    if(news.newsType != HyiNewsImageFlipper)
        return;
    
    HyiImageFlipperNews *imageFlipperNews = (HyiImageFlipperNews *)news;
    self.titleLabel.text = imageFlipperNews.newsTitle;
    [self.contentImageView setImage:[UIImage imageNamed:@"ty_b.jpg"]];
}

// 返回行高
-(int)getCellHeight {
    return 185; // 实际可以根据比例 和 屏幕宽度得到高度
}

@end
