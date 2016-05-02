//
//  XYSearchField.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYSearchField.h"

@implementation XYSearchField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage stretchableImage:[UIImage imageNamed:@"searchbar_textfield_background"]];
        self.font = [UIFont systemFontOfSize:13];
        //设置图片
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageView.width += 10;
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        //
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
