//
//  XYProfileView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYProfileView.h"
#import "XYCountsView.h"
#import "UIImageView+WebCache.h"
#import "XYUsersResult.h"

@interface XYProfileView ()
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  简介
 */
@property (nonatomic, weak) UILabel *descLabel;
/**
 *  vip按钮
 */
@property (nonatomic, weak) UIButton *vipBtn;
/**
 *  分割线
 */
@property (nonatomic, weak) UIView *separateView;
/**
 *  显示数目的视图
 */
@property (nonatomic, weak) XYCountsView *countsView;

@end

@implementation XYProfileView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
    }
    return self;
}
//添加子控件
- (void)setupChildView{
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    
    //昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    //简介
    UILabel *descLable = [[UILabel alloc] init];
    [self addSubview:descLable];
    self.descLabel = descLable;
    descLable.textAlignment = NSTextAlignmentLeft;
    descLable.textColor = [UIColor lightGrayColor];
    descLable.font = [UIFont systemFontOfSize:13];
    descLable.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //分割线
    UIView *separateView = [[UIView alloc] init];
    [self addSubview:separateView];
    separateView.backgroundColor = [UIColor colorWithWhite:0.905 alpha:1.000];
    self.separateView = separateView;
    
    //VIP 按钮
    UIButton *vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:vipBtn];
    self.vipBtn = vipBtn;
    [vipBtn setImage:[UIImage imageNamed:@"common_icon_membership"] forState:UIControlStateNormal];
    [vipBtn setTitle:@"会员>" forState:UIControlStateNormal];
    [vipBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    vipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    //数目
    XYCountsView *countsView = [[XYCountsView alloc] init];
    [self addSubview:countsView];
    self.countsView = countsView;
    
}

//布局控件位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //头像
    CGFloat iconWH = 50;
    CGFloat margin = 5;
    self.iconView.frame = CGRectMake(margin, margin, iconWH, iconWH);
    self.iconView.layer.cornerRadius = iconWH / 2;
    self.iconView.layer.masksToBounds = YES;
    
    //昵称
    self.nameLabel.x = CGRectGetMaxX(_iconView.frame) + margin;
    self.nameLabel.y = 10;
    
    //简介
    self.descLabel.x = self.nameLabel.x;
    self.descLabel.y = CGRectGetMaxY(_nameLabel.frame) + margin;
    
    //vip按钮
    CGFloat vipW = 60;
    CGFloat vipH = 40;
    CGFloat vipX = self.width - vipW - margin;
    CGFloat vipY = 22;
    self.vipBtn.frame = CGRectMake(vipX, vipY, vipW, vipH);
    
    self.separateView.frame = CGRectMake(0, CGRectGetMaxY(_iconView.frame) + margin, self.width, 0.55);
    
    //count view
    self.countsView.frame = CGRectMake(0, CGRectGetMaxY(_separateView.frame) + margin, self.width, 40);
}

//赋值
- (void)setUsersResult:(XYUsersResult *)usersResult{
    _usersResult = usersResult;
    
    //icon
    NSURL *url = [NSURL URLWithString:usersResult.profile_image_url];
    [self.iconView sd_setImageWithURL:url];
    
    //name
    self.nameLabel.text = usersResult.name;
    [self.nameLabel sizeToFit];
    //desc
    self.descLabel.text = [NSString stringWithFormat:@"简介: %@", usersResult.userDescription];;
    [self.descLabel sizeToFit];
    //count
    self.countsView.usersResult = usersResult;
    
    
}
@end
