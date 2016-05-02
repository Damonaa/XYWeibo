//
//  XYOriginalView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYOriginalView.h"
#import "XYPhotosView.h"
#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"
#import "UIImageView+WebCache.h"

@interface XYOriginalView ()
/**
 *  头像
 */
@property (nonatomic, weak) UIImageView *iconView;
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  VIP
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  文本
 */
@property (nonatomic, weak) UILabel *textLabel;
/**
 *  图片视图
 */
@property (nonatomic, weak) XYPhotosView *photosView;
@end

@implementation XYOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupChildView];
        self.image = [UIImage stretchableImage:[UIImage imageNamed:@"timeline_card_top_background"]];
    }
    return self;
}


- (void)setupChildView{
    //icon
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    //name
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    nameLabel.font = XYStatusCellNameFont;
    
    //vip
    UIImageView *vipView = [[UIImageView alloc] init];
    self.vipView = vipView;
    [self addSubview:vipView];
    
    //time
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    timeLabel.font = XYStatusCellTimeFont;
    
    //source
    UILabel *sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    [self addSubview:sourceLabel];
    sourceLabel.font = XYStatusCellTimeFont;
    
    //text
    UILabel *textLable = [[UILabel alloc] init];
    self.textLabel = textLable;
    [self addSubview:textLable];
    textLable.numberOfLines = 0;
    textLable.font = XYStatusCellTextFont;
    
    //photos
    XYPhotosView *photosView = [[XYPhotosView alloc] init];
    self.photosView = photosView;
    [self addSubview:photosView];
}

- (void)setStatusFrame:(XYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //设置frame
    [self setupFrame];
    //赋值
    [self setupData];
}
//赋值
- (void)setupData{
    XYStatus *status = _statusFrame.status;
    
    [_iconView sd_setImageWithURL:status.user.profile_image_url];
    
    _nameLabel.text = status.user.name;
    
    if (status.user.mbtype > 1) {
        _nameLabel.textColor = [UIColor orangeColor];
        _vipView.hidden = NO;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
        _vipView.image = [UIImage imageNamed:vipName];
        
    }else{
        _nameLabel.textColor = [UIColor blackColor];
        _vipView.hidden = YES;
    }
    
    _timeLabel.text = status.created_at;
    
    _sourceLabel.text = status.source;
    
    _textLabel.text = status.text;
    
    _photosView.photoUrls = status.pic_urls;
    
}
//设置frame
- (void)setupFrame{
    
    _iconView.frame = _statusFrame.originalIconFrame;
    _nameLabel.frame = _statusFrame.originalNameFrame;
    _vipView.frame = _statusFrame.originalVipFrame;

    //重写了时间和来源，在这里计算frame，否则重用出错
    //time
    CGFloat timeX = CGRectGetMaxX(_iconView.frame) + XYStatusCellMargin;
    CGFloat timeY = CGRectGetMaxY(_nameLabel.frame) + XYStatusCellMargin;
    CGSize timeSize = [_statusFrame.status.created_at sizeWithAttributes:@{NSFontAttributeName: XYStatusCellTimeFont}];

    _timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};

    //source
    CGFloat sourceX = CGRectGetMaxX(_timeLabel.frame) + XYStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_statusFrame.status.source sizeWithAttributes:@{NSFontAttributeName: XYStatusCellTimeFont}];
    _sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    _textLabel.frame = _statusFrame.originalTextFrame;
    _photosView.frame = _statusFrame.originalPhotosFrame;
    
}
@end
