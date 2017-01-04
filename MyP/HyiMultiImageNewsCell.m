//
//  HyiMultiImageNewsCellTableViewCell.m
//  MyP
//
//  Created by 李全民 on 16/12/31.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "HyiMultiImageNewsCell.h"
#import "HyiNews.h"
#import "HyiColor.h"

@interface HyiMultiImageNewsCell ()
@property(nonatomic) UILabel *titleLabel;
@property(nonatomic) UILabel *sourceLabel;
@property(nonatomic) UIButton *commentButton;
@property(nonatomic) UIImageView *leftImageView;
@property(nonatomic) UIImageView *centerImageView;
@property(nonatomic) UIImageView *rightImageView;
@property(nonatomic) UILabel *countLabel;
@end

@implementation HyiMultiImageNewsCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"HyiMultiImageNewsCell";
    HyiMultiImageNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[HyiMultiImageNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)refreshData:(HyiNews *)news{
    if(news.newsType != HyiNewsMultiImage)
        return;

    
}

-(int)getCellHeight {
    return 165;
}
@end
