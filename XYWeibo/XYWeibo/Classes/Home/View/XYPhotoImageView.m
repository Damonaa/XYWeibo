//
//  XYPhotoImageView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYPhotoImageView.h"
#import "UIImageView+WebCache.h"

@interface XYPhotoImageView ()

//给gif图上添加个标志
@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation XYPhotoImageView

//懒加载创建一个GIF标志
- (UIImageView *)gifView{
    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        _gifView = gifView;
        [self addSubview:gifView];
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}


//设置图片
- (void)setPhotoUrl:(NSString *)photoUrl{
    _photoUrl = photoUrl;
//    NSLog(@"%@", photoUrl);
    
    NSURL *url = [NSURL URLWithString:photoUrl];
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([photoUrl hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}
@end
