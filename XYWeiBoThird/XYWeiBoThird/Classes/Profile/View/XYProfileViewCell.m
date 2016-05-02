//
//  XYProfileViewCell.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYProfileViewCell.h"
#import "XYProfileItem.h"

@interface XYProfileViewCell ()

/**
 *  子标题
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 *  子标题
 */
@property (nonatomic, weak) UILabel *subtitleLabel;
/**
 *  accessory view 为箭头图片
 */
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation XYProfileViewCell


//懒加载
- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}

+ (instancetype)profileViewCellWithTableView:(UITableView *)tableView{
    static NSString *reusedID = @"profileCell";
    XYProfileViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    
    if (!cell) {
        cell = [[XYProfileViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusedID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        //子标题
        UILabel *subtitleLabel = [[UILabel alloc] init];
        self.subtitleLabel = subtitleLabel;
        [self.contentView addSubview:subtitleLabel];
        subtitleLabel.font = [UIFont systemFontOfSize:14];
        subtitleLabel.textAlignment = NSTextAlignmentLeft;
        subtitleLabel.textColor = [UIColor lightGrayColor];
        //分割线
        UIView *separatedView = [[UIView alloc] init];
        [self.contentView addSubview:separatedView];
        separatedView.backgroundColor = [UIColor colorWithWhite:0.905 alpha:1.000];
        separatedView.frame = CGRectMake(0, self.height - 0.55, XYScreenWidth, 0.55);
        
    }
    
    return self;
}

//赋值
- (void)setProfileItem:(XYProfileItem *)profileItem{
    _profileItem = profileItem;
    
    if (profileItem.icon) {
        self.imageView.image = profileItem.icon;
    }
    
    //标题
    self.titleLabel.text = profileItem.title;
    [self.titleLabel sizeToFit];
    self.titleLabel.x = 47;
    self.titleLabel.y = (self.height - self.titleLabel.height ) / 2;
    
    //子标题
    if (profileItem.subTitle) {
        self.subtitleLabel.text = profileItem.subTitle;
        [self.subtitleLabel sizeToFit];
        self.subtitleLabel.x = CGRectGetMaxX(_titleLabel.frame) + 5;
        self.subtitleLabel.y = (self.height - self.subtitleLabel.height ) / 2;
    }
    
    self.accessoryView = self.arrowView;
}
@end
