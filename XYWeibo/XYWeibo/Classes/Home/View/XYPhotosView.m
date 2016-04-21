//
//  XYPhotosView.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYPhotosView.h"
#import "XYPhotoImageView.h"
#import "XYPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface XYPhotosView ()

/**
 *  存放9个 XYPhotoImageView
 */
@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation XYPhotosView

- (NSMutableArray *)imageViews{
    if (!_imageViews) {
        _imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < 9; i ++) {
            XYPhotoImageView *imageView = [[XYPhotoImageView alloc] init];
            imageView.photoUrl = self.photoUrls[i];
            imageView.tag = i;
            [self addSubview:imageView];
            [self.imageViews addObject:imageView];
            
            //添加点击手势，查看大图
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [imageView addGestureRecognizer:tap];
            
        }
    }
    return self;
}
//查看大图
- (void)tapImageView:(UITapGestureRecognizer *)gesture{
    
    UIImageView *tapImage = (UIImageView *)gesture.view;
    
    //将XYPhoto转为MJPhoto
    NSMutableArray *photoArray = [NSMutableArray array];
    
    int i = 0;
    for (XYPhoto *photo in self.photoUrls) {
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        //将模糊的image URL转为清晰的
        NSString *urlStr = [photo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:urlStr];
        mjPhoto.index = i;
        mjPhoto.srcImageView = tapImage;
        [photoArray addObject:mjPhoto];
        i ++;
    }
    
    //弹出图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photoArray;
    browser.currentPhotoIndex = tapImage.tag;
    [browser show];
    
}
//设置图片的URL
- (void)setPhotoUrls:(NSArray *)photoUrls{
    _photoUrls = photoUrls;
    
    for (int i = 0; i < photoUrls.count; i ++) {
        XYPhotoImageView *iv = self.imageViews[i];
        XYPhoto *photo = photoUrls[i];
        iv.photoUrl = photo.thumbnail_pic;
       
    }
}


//布局imagview
- (void)layoutSubviews{
    [super layoutSubviews];
    
    int colume = self.photoUrls.count == 4 ? 2 : 3;
    
    CGFloat imageHW = 70;   
    for (int i = 0 ; i < 9; i++) {
        XYPhotoImageView *iv = self.imageViews[i];
        
        if (i < self.photoUrls.count) {
            iv.hidden = NO;
            int row = i / colume;
            int currentColumn = i % colume;
           CGFloat imageX = (imageHW + XYMarginCell) * currentColumn;
           CGFloat imageY = (imageHW + XYMarginCell) * row;
            iv.frame = CGRectMake(imageX, imageY, imageHW, imageHW);
            
//            NSLog(@"frame ---- %@", NSStringFromCGRect(iv.frame));
            
        }else{//隐藏
            iv.hidden = YES;
        }
    }
}
@end
