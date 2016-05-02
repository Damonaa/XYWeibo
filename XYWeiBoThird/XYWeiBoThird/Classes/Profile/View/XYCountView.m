//
//  XYCountView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYCountView.h"

@interface XYCountView ()
/**
 *  显示总数的label
 */
@property (nonatomic, weak) UILabel *countLabel;
/**
 *  显示类型
 */
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation XYCountView

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
    UILabel *countLabel = [[UILabel alloc] init];
    [self addSubview:countLabel];
    self.countLabel = countLabel;
    countLabel.font = [UIFont systemFontOfSize:14];
    countLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor lightGrayColor];

}

//赋值
- (void)setName:(NSString *)name{
    _name = name;
    self.nameLabel.text = name;
}

- (void)setCount:(NSString *)count{
    _count = count;
    self.countLabel.text = count;
}
//布局
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.countLabel.x = 0;
    self.countLabel.y = 0;
//    [self.countLabel sizeToFit];
    self.countLabel.width = self.width;
    self.countLabel.height = 20;
    
    self.nameLabel.x = 0;
    self.nameLabel.y = CGRectGetMaxY(self.countLabel.frame);
    [self.nameLabel sizeToFit];
    self.nameLabel.width = self.width;
    
}

@end
