//
//  XYSettingViewCell.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYSettingViewCell.h"
#import "XYProfileItem.h"
#import "XYProfileItemArrow.h"
#import "XYProfileItemSwitch.h"

@interface XYSettingViewCell ()
/**
 *  accessory view 为箭头图片
 */
@property (nonatomic, strong) UIImageView *arrowView;
/**
 *  accessory view 为UISwitch
 */
@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation XYSettingViewCell


//懒加载
- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}
- (UISwitch *)switchView{
    if (!_switchView) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchView;
}

/**
 *  记录保存 UISwitch 的默认选择
 */
- (void)switchValueChange:(UISwitch *)sender{
    NSUserDefaults *switchDefault = [NSUserDefaults standardUserDefaults];
    [switchDefault setBool:sender.isOn forKey:self.profileItem.title];
    [switchDefault synchronize];
}

//初始化
+ (instancetype)settingViewCellWithTableView:(UITableView *)tableView{
    static NSString *reusedID = @"profileCell";
    XYSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    
    if (!cell) {
        cell = [[XYSettingViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusedID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    self.textLabel.text = profileItem.title;
    //子标题
    if (profileItem.subTitle) {
        self.detailTextLabel.text = profileItem.subTitle;
    }
    
    if ([profileItem isKindOfClass:[XYProfileItemArrow class]]) {
       self.accessoryView = self.arrowView;
    }else if([profileItem isKindOfClass:[XYProfileItemSwitch class]]){
        self.switchView.on = [[NSUserDefaults standardUserDefaults] boolForKey:self.profileItem.title];
        self.accessoryView = self.switchView;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
}

@end
