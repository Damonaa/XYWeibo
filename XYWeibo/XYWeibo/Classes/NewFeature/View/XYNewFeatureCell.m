//
//  XYNewFeatureCell.m
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYNewFeatureCell.h"
#import "XYMainTabBarController.h"

@interface XYNewFeatureCell ()
/**
 *  展示cell图片
 */
@property (nonatomic, weak) UIImageView *imageView;

/**
 *  分享按钮
 */
@property (nonatomic, weak) UIButton *shareBtn;
/**
 *  开始进入主界面按钮
 */
@property (nonatomic, weak) UIButton *startBtn;

@end

@implementation XYNewFeatureCell
//懒加载
- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageView = imageView;
        [self addSubview:imageView];
    }
    return _imageView;
}

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn = btn;
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitle:@"分享给好友" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchDown];
        [btn sizeToFit];
        [self addSubview:btn];
    }
    return _shareBtn;
}

- (UIButton *)startBtn{
    if (!_startBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn = btn;
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [btn setTitle:@"开始浪吧" forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return _startBtn;
}
//选中是否分享
- (void)shareBtnClick:(UIButton *)button{
    button.selected = !button.selected;
}
//进入主视图, 切换根控制器
- (void)startBtnClick{
    XYMainTabBarController *mainTBC = [[XYMainTabBarController alloc] init];
    
    XYKeyWindow.rootViewController = mainTBC;
}
//设置imageView的image
- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}



/**
 *  布局设置控件的位置
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    self.shareBtn.center = CGPointMake(w / 2, h * 0.8);
    self.startBtn.center = CGPointMake(w / 2, h * 0.9);
}
/**
 *  判断当前的cell是第几个cell
 *  来决定是否展示按钮
 *  @param indexPath 当前的cell
 *  @param count     总的cell数
 */
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{
    if (indexPath.row == count - 1) {
        self.startBtn.hidden = NO;
        self.shareBtn.hidden = NO;
    }else{
        self.startBtn.hidden = YES;
        self.shareBtn.hidden = YES;
    }
}

@end
