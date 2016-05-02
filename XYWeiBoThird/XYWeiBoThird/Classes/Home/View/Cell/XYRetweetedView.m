//
//  XYRetweetedView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYRetweetedView.h"
#import "XYPhotosView.h"
#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"

@interface XYRetweetedView ()
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  文本
 */
@property (nonatomic, weak) UILabel *textLabel;
/**
 *  图片视图
 */
@property (nonatomic, weak) XYPhotosView *photosView;
@end


@implementation XYRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupChildView];
        self.image = [UIImage stretchableImage:[UIImage imageNamed:@"timeline_retweet_background"]];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setupChildView{
    //name
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    nameLabel.font = XYStatusCellNameFont;
    
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
    
    //赋值
    [self setupData];
    //设置frame
    [self setupFrame];
    
}
//赋值
- (void)setupData{
    XYStatus *status = _statusFrame.status.retweeted_status;
    
    _nameLabel.text = [NSString stringWithFormat:@"@%@", status.user.name];
    
    _textLabel.text = status.text;
    
    _photosView.photoUrls = status.pic_urls;
    
}
//设置frame
- (void)setupFrame{
    _nameLabel.frame = _statusFrame.retweetedNameFrame;
    _textLabel.frame = _statusFrame.retweetedTextFrame;
    _photosView.frame = _statusFrame.retweetedPhotosFrame;
    
}

@end
