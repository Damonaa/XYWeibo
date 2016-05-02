//
//  XYRepostView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/5/1.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYRepostView.h"
#import "XYStatus.h"
#import "XYUser.h"
#import "XYPhoto.h"
#import "UIImageView+WebCache.h"

@interface XYRepostView ()
/**
 *  预览转发微博的图片，若没有，显示用户头像
 */
@property (nonatomic, weak) UIImageView *previewIV;
/**
 *  被转发者的昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;

/**
 *  被转发者的text
 */
@property (nonatomic, weak) UILabel *textLabel;
@end

@implementation XYRepostView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildView];
        self.backgroundColor = [UIColor colorWithWhite:0.948 alpha:1.000];
    }
    return self;
}
//添加子控件
- (void)setupChildView{
 //预览图片
    UIImageView *previewIV = [[UIImageView alloc] init];
    [self addSubview:previewIV];
    self.previewIV = previewIV;
    previewIV.contentMode = UIViewContentModeScaleAspectFill;
    previewIV.clipsToBounds = YES;
    
    //被转发的用户的昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    
    
    UILabel *textLabel = [[UILabel alloc] init];
    [self addSubview:textLabel];
    self.textLabel = textLabel;
    textLabel.numberOfLines = 2;
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.textAlignment = NSTextAlignmentLeft;
    
}
//布局子控件位置
- (void)setStatus:(XYStatus *)status{
    _status = status;
    CGFloat w = self.width;
    CGFloat h = self.height;
    //预览图片
    
    NSURL *url;
    if (status.retweeted_status) {
        if (status.retweeted_status.pic_urls.count > 0) {//有图
            url = [status.retweeted_status.pic_urls[0] thumbnail_pic];
        }else{//无图
            url = status.retweeted_status.user.profile_image_url;
        }
        self.nameLabel.text = [NSString stringWithFormat:@"@%@", status.retweeted_status.user.name];
        self.textLabel.text = status.retweeted_status.text;
    }else{//原创
        if (status.pic_urls.count > 0) {//有图
            url = [status.pic_urls[0] thumbnail_pic];
        }else{//无图
           url = status.user.profile_image_url;
        }
        self.nameLabel.text = [NSString stringWithFormat:@"@%@", status.user.name];
        self.textLabel.text = status.text;
    }
    
    [self.previewIV sd_setImageWithURL:url];
    self.previewIV.frame = CGRectMake(0, 0, h, h);
    //被转发的用户昵称
    
    
    
    [self.nameLabel sizeToFit];
    self.nameLabel.x = CGRectGetMaxY(_previewIV.frame) + 5;
    self.nameLabel.y = 5;
    
    //被转发的用户text
   
    [self.textLabel sizeToFit];
    
    
    self.textLabel.x = self.nameLabel.x;
    self.textLabel.y = CGRectGetMaxY(_nameLabel.frame) + 2;
    self.textLabel.width = w - h - 5;
    self.textLabel.height = h - self.textLabel.y;
}
@end
