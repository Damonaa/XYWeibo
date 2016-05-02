//
//  XYNotifiViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/5/1.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYNotifiViewController.h"
#import "XYProfileItem.h"
#import "XYProfileGroup.h"
#import "XYSettingViewCell.h"
#import "XYProfileItemArrow.h"
#import "XYProfileItemSwitch.h"
#import "XYIntervalViewController.h"

@interface XYNotifiViewController ()

@property (nonatomic, strong) XYProfileItem *item14;

@end

@implementation XYNotifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.scrollEnabled = YES;
    
    //监听通知，interval的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(intervalChange:) name:@"selectedInterval" object:nil];
    
    XYProfileItem *item1 = [XYProfileItemArrow profileItemWithIcon:nil title:@"账号管理" subTitle:@"已开启" destVC:nil];
    XYProfileGroup *group1 = [[XYProfileGroup alloc] init];
    group1.footerTitle = @"要开启或者关不微博的推送通知，请设置iPhone的“设置”-“通知”中找到“微博”进行设置";
    group1.groupItems = @[item1];
    
    
    XYProfileItem *item2 = [XYProfileItemArrow profileItemWithIcon:nil title:@"@我的" subTitle:@"所有人" destVC:nil];
    XYProfileItem *item3 = [XYProfileItemArrow profileItemWithIcon:nil title:@"评论" subTitle:@"所有人" destVC:nil];
    XYProfileItem *item4 = [XYProfileItemArrow profileItemWithIcon:nil title:@"赞" subTitle:nil destVC:nil];
    XYProfileItem *item5 = [XYProfileItemSwitch profileItemWithIcon:nil title:@"消息" subTitle:nil destVC:nil];
    XYProfileItem *item6 = [XYProfileItemSwitch profileItemWithIcon:nil title:@"群通知" subTitle:nil destVC:nil];
    XYProfileItem *item7 = [XYProfileItemArrow profileItemWithIcon:nil title:@"未关注人消息" subTitle:@"我关注的人" destVC:nil];
    XYProfileItem *item8 = [XYProfileItemArrow profileItemWithIcon:nil title:@"新粉丝" subTitle:@"所有人" destVC:nil];
    XYProfileGroup *group2 = [[XYProfileGroup alloc] init];
    group2.headerTitle = @"新消息通知";
    group2.groupItems = @[item2, item3, item4, item5, item6, item7, item8];
    
    XYProfileItem *item9 = [XYProfileItemSwitch profileItemWithIcon:nil title:@"好友圈微博" subTitle:nil destVC:nil];
    XYProfileItem *item10 = [XYProfileItemArrow profileItemWithIcon:nil title:@"特别关注微博" subTitle:@"智能" destVC:nil];
    XYProfileItem *item11 = [XYProfileItemSwitch profileItemWithIcon:nil title:@"群微博" subTitle:nil destVC:nil];
    XYProfileItem *item12 = [XYProfileItemSwitch profileItemWithIcon:nil title:@"微博热点" subTitle:nil destVC:nil];
    XYProfileGroup *group3 = [[XYProfileGroup alloc] init];
    group3.headerTitle = @"新微博推送通知";
    group3.groupItems = @[item9, item10, item11, item12];
    
    XYProfileItem *item13 = [XYProfileItemArrow profileItemWithIcon:nil title:@"免打扰设置" subTitle:nil destVC:nil];
    
    //获取默认保存的偏好设置
    NSInteger index = [[NSUserDefaults standardUserDefaults] integerForKey:XYSelectedIndex];
    
    self.item14 = [XYProfileItemArrow profileItemWithIcon:nil title:@"获取新消息" subTitle:[self setupIntervalWithIndex:index] destVC:[XYIntervalViewController class]];
    
    XYProfileGroup *group4 = [[XYProfileGroup alloc] init];
    group4.groupItems = @[item13, self.item14];
    
    [self.groups addObjectsFromArray:@[group1, group2, group3, group4]];
}


#pragma mark - uitableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYSettingViewCell *cell = [XYSettingViewCell settingViewCellWithTableView:tableView];
    
    NSArray *items = [self.groups[indexPath.section] groupItems];
    XYProfileItem *profileItem = items[indexPath.row];
    cell.profileItem = profileItem;

    
    return cell;
}

- (void)intervalChange:(NSNotification *)noti{
    NSInteger index = [noti.userInfo[@"selectedInterval"] integerValue];
    self.item14.subTitle = [self setupIntervalWithIndex:index];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (NSString *)setupIntervalWithIndex:(NSInteger )index{
    NSString *intervalStr;
    switch (index) {
        case 0:
            intervalStr= @"每半分钟";
            break;
            
        case 1:
            intervalStr = @"每2分钟";
            break;
            
        case 2:
            intervalStr = @"每5分钟";
            break;
            
        case 3:
            intervalStr = @"永不";
            break;
        default:
            intervalStr= @"每半分钟";
            break;
    }
    return intervalStr;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
