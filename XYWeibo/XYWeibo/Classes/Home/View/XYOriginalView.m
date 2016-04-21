//
//  XYOriginalView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYOriginalView.h"
#import "XYPhotosView.h"
#import "XYStatus.h"
#import "XYStatusFrame.h"
#import "XYUser.h"
#import "UIImageView+WebCache.h"
#import "UIImage+XYCategory.h"

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
 *  vip图片
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  创建时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;
/**
 *  配图
 */
@property (nonatomic, weak) XYPhotosView *photosView;

@end

@implementation XYOriginalView

//初始化创建UI
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupAllChildUI];
//        self.backgroundColor = [UIColor redColor];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageStretchableWithImage: [UIImage imageNamed:@"timeline_card_top_background"]];
    }
    return self;
}
//添加子控件
- (void)setupAllChildUI{
    //icon
    UIImageView *iconView = [[UIImageView alloc] init];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    //name
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    nameLabel.font = XYOriginalNameFont;
    nameLabel.textColor = [UIColor orangeColor];
    
    //vip
    UIImageView *vipView = [[UIImageView alloc] init];
    self.vipView = vipView;
    [self addSubview:vipView];
    
    //time
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    timeLabel.font = XYOriginalTimeFont;
    
    //source
    UILabel *sourceLabel = [[UILabel alloc] init];
    self.sourceLabel = sourceLabel;
    [self addSubview:sourceLabel];
    sourceLabel.font = XYOriginalTimeFont;
    
    //text
    UILabel *textLabel = [[UILabel alloc] init];
    self.textLabel = textLabel;
    [self addSubview:textLabel];
    textLabel.font = XYOriginalTextFont;
    textLabel.numberOfLines = 0;
    
    //photos
    XYPhotosView *photosView = [[XYPhotosView alloc] init];
    self.photosView = photosView;
    [self addSubview:photosView];
}

- (void)setStatusFrame:(XYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    //设置控件的frame
    [self setupUIFrameWithStatusFrame:statusFrame];
    //设置控件的数据
    [self setupUIDataWithStatusFrame:statusFrame];
}
//设置控件的frame
- (void)setupUIFrameWithStatusFrame:(XYStatusFrame *)statusFrame{
    XYStatus *status = statusFrame.status;
    
    self.iconView.frame  = statusFrame.originalIconFrame;
    self.nameLabel.frame = statusFrame.originalNameFrame;
    
    if (status.user.isVip) {
        self.vipView.frame = statusFrame.originalVipFrame;
    }
    
    //create time
    CGFloat timeW = [status.created_at sizeWithAttributes:@{NSFontAttributeName: XYOriginalTimeFont}].width;
    CGFloat timeH = 10;
    CGFloat timeX = CGRectGetMaxX(statusFrame.originalIconFrame) + XYMarginCell;
    CGFloat timeY = CGRectGetMaxY(statusFrame.originalNameFrame) + XYMarginCell;
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeW, timeH);
    
    //source
    CGFloat sourceW = [status.source sizeWithAttributes:@{NSFontAttributeName:XYOriginalTimeFont}].width;
    CGFloat sourceH = timeH;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + XYMarginCell;
    CGFloat sourceY = timeY;
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    
    self.textLabel.frame = statusFrame.originalTextFrame;

    self.photosView.frame = statusFrame.originalPhotoFrame;

}
//设置控件的数据
- (void)setupUIDataWithStatusFrame:(XYStatusFrame *)statusFrame{
    XYStatus *status = statusFrame.status;
    
    [self.iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.nameLabel.text = status.user.name;
    
    NSString *vipImageStr = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    self.vipView.image = [UIImage imageNamed:vipImageStr];
    
    self.timeLabel.text = status.created_at;
    self.sourceLabel.text = status.source;
    
    self.textLabel.text = status.text;
    
    self.photosView.photoUrls = status.pic_urls;
    
}

@end
