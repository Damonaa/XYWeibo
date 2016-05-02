//
//  XYPhotosView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYPhotosView.h"
#import "XYSinglePhoto.h"
#import "XYPhoto.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface XYPhotosView ()

@end

@implementation XYPhotosView

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
    for (int i = 0; i < 9; i++) {
        //
        XYSinglePhoto *singlePhoto = [[XYSinglePhoto alloc] init];
        singlePhoto.tag = i;
        [self addSubview:singlePhoto];

        singlePhoto.hidden = YES;
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagImage:)];
        [singlePhoto addGestureRecognizer:tap];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger count = _photoUrls.count;
    
    NSInteger totalColumn = count == 4 ? 2 : 3;

    
    CGFloat photoWH = 70;
   
    
    for (NSInteger i = 0; i < self.subviews.count; i ++) {
        XYSinglePhoto *photo = self.subviews[i];
        
        if (i < count) {//有URL 显示
            photo.hidden = NO;
            NSInteger column = i % totalColumn;
            NSInteger row = i / totalColumn;
            
            CGFloat x = (photoWH + XYStatusCellMargin) * column;
            CGFloat y = (photoWH + XYStatusCellMargin) * row;
            photo.frame = CGRectMake(x, y, photoWH, photoWH);
        }else{//无 URL 隐藏
            photo.hidden = YES;
        }
        
    }
    
}
//设置图片
- (void)setPhotoUrls:(NSArray *)photoUrls{
    _photoUrls = photoUrls;

    for (int i = 0; i < photoUrls.count; i ++) {
        XYSinglePhoto *singlePhoto = self.subviews[i];
        XYPhoto *photo = photoUrls[i];
        singlePhoto.picUrl = photo.thumbnail_pic;
    }
}

//处理手势
- (void)tagImage:(UITapGestureRecognizer *)gesture{
    XYSinglePhoto *photo = (XYSinglePhoto *)gesture.view;
    
    NSMutableArray *mjPhotosM = [NSMutableArray array];
    
    for (int i = 0; i < _photoUrls.count; i ++) {
        XYPhoto *selfPhoto = _photoUrls[i];
        NSString *urlStr = selfPhoto.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        MJPhoto *mjPhoto = [[MJPhoto alloc] init];
        mjPhoto.url = [NSURL URLWithString:urlStr];
        mjPhoto.index = i;
        mjPhoto.srcImageView = photo;
        
        [mjPhotosM addObject:mjPhoto];
    }
    
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = mjPhotosM;
    browser.currentPhotoIndex = photo.tag;
    
    [browser show];
}
@end
