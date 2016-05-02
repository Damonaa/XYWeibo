//
//  XYProfileTableView.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYProfileTableViewController.h"
#import "XYProfileItem.h"
#import "XYProfileGroup.h"
#import "XYProfileViewCell.h"
#import "XYProfileItemArrow.h"


@implementation XYProfileTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    
    XYProfileItem *item1 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"new_friend"] title:@"新的好友" subTitle:nil destVC:nil];
    XYProfileItem *item2 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"vip"] title:@"微博等级" subTitle:@"升等级，得奖励" destVC:nil];
    
    XYProfileGroup *group1 = [[XYProfileGroup alloc] init];
    group1.groupItems = @[item1, item2];
    
    
    XYProfileItem *item3 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"album"] title:@"我的相册" subTitle:nil destVC:nil];
    XYProfileItem *item4 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"collect"] title:@"我的点评" subTitle:nil destVC:nil];
    XYProfileItem *item5 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"like"] title:@"我的赞" subTitle:nil destVC:nil];
    
    XYProfileGroup *group2 = [[XYProfileGroup alloc] init];
    group2.groupItems = @[item3, item4, item5];
    
    XYProfileItem *item6 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"pay"] title:@"微博支付" subTitle:@"积分好礼换不停" destVC:nil];
    XYProfileItem *item7 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"pay"] title:@"微博运动" subTitle:@"奔跑2016搬到这里啦" destVC:nil];
    
    XYProfileGroup *group3 = [[XYProfileGroup alloc] init];
    group3.groupItems = @[item6, item7];
    
    
    XYProfileItem *item8 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"pay"] title:@"粉丝头条" subTitle:@"推广博文及账号的利器" destVC:nil];
    XYProfileItem *item9 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"pay"] title:@"粉丝服务" subTitle:@"橱窗，私信，营销，数据中心" destVC:nil];
    XYProfileGroup *group4 = [[XYProfileGroup alloc] init];
    group4.groupItems = @[item8, item9];
    
    XYProfileItem *item10 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"draft"] title:@"草稿箱" subTitle:nil destVC:nil];
    XYProfileGroup *group5 = [[XYProfileGroup alloc] init];
    group5.groupItems = @[item10];
    
    
    XYProfileItem *item11 = [XYProfileItemArrow profileItemWithIcon:[UIImage imageNamed:@"like"] title:@"更多" subTitle:@"文章、收藏" destVC:nil];
    XYProfileGroup *group6 = [[XYProfileGroup alloc] init];
    group6.groupItems = @[item11];
    
    [self.groups addObjectsFromArray:@[group1, group2, group3, group4, group5, group6]];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYProfileViewCell *cell = [XYProfileViewCell profileViewCellWithTableView:tableView];
    
    NSArray *items = [self.groups[indexPath.section] groupItems];
    XYProfileItem *profileItem = items[indexPath.row];
    cell.profileItem = profileItem;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
@end
