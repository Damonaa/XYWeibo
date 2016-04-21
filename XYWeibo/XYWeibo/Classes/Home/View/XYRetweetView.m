//
//  XYRetweetView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYRetweetView.h"
#import "XYPhotosView.h"
#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"
#import "UIImage+XYCategory.h"

@interface XYRetweetView ()
/**
 *  昵称
 */
@property (nonatomic, weak) UILabel *nameLabel;
/**
 *  正文
 */
@property (nonatomic, weak) UILabel *textLabel;
/**
 *  配图
 */
@property (nonatomic, weak) XYPhotosView *photosView;

@end

@implementation XYRetweetView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setupAllChildUI];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageStretchableWithImage:[UIImage imageNamed:@"timeline_retweet_background"]];
    }
    return self;
}

//添加子控件
- (void)setupAllChildUI{
    //name
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    nameLabel.font = XYRetweetNameFont;
    nameLabel.textColor = [UIColor colorWithRed:0.482 green:0.763 blue:0.707 alpha:1.000];
    
    //text
    UILabel *textLabel = [[UILabel alloc] init];
    self.textLabel = textLabel;
    [self addSubview:textLabel];
    textLabel.font = XYRetweetTextFont;
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
//    XYStatus *status = statusFrame.status.retweeted_status;
    
    self.nameLabel.frame = statusFrame.retweetNameFrame;
    
    self.textLabel.frame = statusFrame.retweetTextFrame;

    self.photosView.frame = statusFrame.retweetPhotosFrame;

}
//设置控件的数据
- (void)setupUIDataWithStatusFrame:(XYStatusFrame *)statusFrame{
    XYStatus *status = statusFrame.status.retweeted_status;
    
    self.nameLabel.text = status.user.name;
    self.textLabel.text = status.text;
    
    self.photosView.photoUrls = status.pic_urls;
    
}
@end
