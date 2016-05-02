//
//  XYHomeViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYHomeViewController.h"
#import "UIBarButtonItem+Category.h"
#import "XYTitleButton.h"
#import "XYCover.h"
#import "XYPopListView.h"
#import "XYTitleListController.h"
#import "XYStatusTool.h"
#import "XYStatusCell.h"
#import "XYStatus.h"
#import "XYStatusFrame.h"
#import "MJRefresh.h"
#import "XYUsersTool.h"
#import "XYAccountTool.h"
#import "XYAccountResult.h"
#import "XYComposeViewController.h"
#import "XYTextView.h"
#import "XYUser.h"
#import "XYMainNavigationController.h"

@interface XYHomeViewController ()<XYCoverDelegate>

/**
 *  标题按钮
 */
@property (nonatomic, weak) XYTitleButton *titleButton;
/**
 *  点击标题的弹窗
 */
@property (nonatomic, weak) XYPopListView *popView;
/**
 *  点击标题的弹窗控制器
 */
@property (nonatomic, strong) XYTitleListController *titleList;
/**
 *  存放全部的微博数据
 */
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation XYHomeViewController

- (NSMutableArray *)statuses{
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航条
    [self setupNavigationBar];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.view.backgroundColor = [UIColor colorWithWhite:0.865 alpha:1.000];
    
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //获取用户信息
    [self getUsersInfo];
    
    //监听工具条按钮的点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickToolBarBtn:) name:@"clickToolBarBtn" object:nil];
}

//刷新微博
- (void)refreshTableViewHeader{
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 获取用户信息
- (void)getUsersInfo{
    //获取用户信息
    [XYUsersTool getUsersShowWithSuccess:^(XYUsersResult *result) {
        //取出结果的用户昵称
        XYAccountResult *accountResult = [XYAccountTool accountResult];
        accountResult.name = result.name;
        XYLog(@"%@, %@, %@,%@", result.screen_name, result.location, result.followers_count, result.favourites_count);
        [XYAccountTool saveAccount:accountResult];
    } failure:^(NSError *error) {
        XYLog(@"%@", error);
    }];
}

#pragma mark -下拉刷新
- (void)headerRereshing{
    
    NSString *sinceID;
    if (self.statuses.count > 0) {
        XYStatus *statue = [_statuses[0] status];
        sinceID = statue.idstr;
    }
    
    [XYStatusTool getNewStatusesWithSinceID:sinceID success:^(NSArray *statuses) {
        
        [self showNewStatusCount:statuses.count];
        
        NSMutableArray *statusM = [NSMutableArray array];
        for (XYStatus *status in statuses) {
            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
            statusFrame.status = status;
            [statusM addObject:statusFrame];
        }
        
        
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statusM.count)];
        
        [self.statuses insertObjects:statusM atIndexes:indexSet];
        
        [self.tableView reloadData];
        [self.tableView headerEndRefreshing];
        //刷新成功后，清楚Badgevalue
        self.tabBarItem.badgeValue = nil;
        
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        XYLog(@"%@", error);
    }];
}

/**
 *  显示提示框
 *
 *  @param count 新的微博数
 */
- (void)showNewStatusCount:(NSInteger)count{
    
    if (count == 0) {
        return;
    }
    
    UILabel *remind = [[UILabel alloc] init];
    remind.text = [NSString stringWithFormat:@"最新的微博数%ld", count];
    
    CGFloat remindW = self.view.width;
    CGFloat remindH = 35;
    CGFloat remindX = 0;
    CGFloat remindY = CGRectGetMaxY(self.navigationController.navigationBar.frame) - remindH;
    remind.frame = CGRectMake(remindX, remindY, remindW, remindH);
    
    remind.backgroundColor = [UIColor orangeColor];
    remind.textColor = [UIColor whiteColor];
    remind.textAlignment = NSTextAlignmentCenter;
    
    //    将label插入到导航条的底部
    [self.navigationController.view insertSubview:remind belowSubview:self.navigationController.navigationBar];
    
    //    下拉刷新，label下移动，刷新结束后，延时 复位 移除
    [UIView animateWithDuration:0.25 animations:^{
        remind.transform = CGAffineTransformMakeTranslation(0, remindH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:1.3 options:UIViewAnimationOptionCurveLinear animations:^{
            remind.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [remind removeFromSuperview];
        }];
    }];
}

#pragma mark - 上拉获取更多
- (void)footerRefreshing{
    
    NSString *maxID = nil;
    if (_statuses.count) {
        XYStatus *status = [[_statuses lastObject] status];
        maxID = [NSString stringWithFormat:@"%lld", [status.idstr longLongValue] - 1];
    }
    
    [XYStatusTool getMoreStatusesWithSinceID:maxID success:^(NSArray *statuses) {
    
        NSMutableArray *statusM = [NSMutableArray array];
        for (XYStatus *status in statuses) {
            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
            statusFrame.status = status;
            [statusM addObject:statusFrame];
        }
        
        [self.statuses addObjectsFromArray:statusM];
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
        
    } failure:^(NSError *error) {
        XYLog(@"%@", error);
        [self.tableView footerEndRefreshing];
    }];
    
}

#pragma mark - 设置导航条
- (void)setupNavigationBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] selectedImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(leftBarButtonClick) controlEvent:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] selectedImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(rightBarButtonClick) controlEvent:UIControlEventTouchUpInside];
    
    XYTitleButton *titleButton = [XYTitleButton buttonWithType:UIButtonTypeCustom];
    self.titleButton = titleButton;
    //先从沙盒中取名字
    NSString *titleName = [XYAccountTool accountResult].name ? [XYAccountTool accountResult].name : @"首页";

    [titleButton setTitle:titleName forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYStatusCell *cell = [XYStatusCell statusCellWithTableView:tableView];

    cell.statusFrame = self.statuses[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYStatusFrame *statusFrame = self.statuses[indexPath.row];
    
    return statusFrame.rowHeight;
}

#pragma mark - navigationItemClick
//点击标题
- (void)titleClick:(XYTitleButton *)button{
    button.selected = !button.selected;
    
    XYCover *cover = [XYCover show];
    cover.delegate = self;
    
    CGFloat popW = 200;
    CGFloat popH = 200;
    CGFloat popX = (self.view.width - popW ) /2;
    CGFloat popY = 55;
    XYPopListView *popView = [XYPopListView popListViewAtRect:CGRectMake(popX, popY, popW, popH)];
    self.popView = popView;
    self.titleList = [[XYTitleListController alloc] init];
    popView.contentView = _titleList.view;

}

- (void)leftBarButtonClick{
    
}
- (void)rightBarButtonClick{
    
}
#pragma mark - XYCoverDelegate点击蒙版
- (void)coverDidClick{
    self.titleButton.selected = NO;
    [XYPopListView hide];
    
}

#pragma mark - 处理工具栏按钮的点击
- (void)clickToolBarBtn:(NSNotification *)noti{
    NSInteger btnTag = [noti.userInfo[@"clickToolBarBtn"] integerValue];
    XYStatusCell *selectedCell = noti.userInfo[@"clickCell"];
    XYLog(@"%ld, --- %@", btnTag, selectedCell.statusFrame.status);
    switch (btnTag) {
        case 0:
            //转发
            [self repostStatusWithStatus:selectedCell.statusFrame.status];
            break;
        case 1:
            //评论
            [self commentStatusWithStatus:selectedCell.statusFrame.status];
            break;
        case 2:
            //点赞
            break;
    }
}

//转发微博
- (void)repostStatusWithStatus:(XYStatus *)status{
    XYComposeViewController *composeVC = [[XYComposeViewController alloc] init];
    composeVC.title = @"转发微博";
    composeVC.repostStatus = YES;
    composeVC.status = status;
    if (status.retweeted_status) {//转发转发的微博
        composeVC.repostText = [NSString stringWithFormat:@"//@%@:%@", status.user.name, status.text];
    }else{//转发原创的微博
        composeVC.repostPlacehold = @"说说你的分享心得";
    }
    
    XYMainNavigationController *mainNav = [[XYMainNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:mainNav animated:YES completion:nil];
}
//评论微博
- (void)commentStatusWithStatus:(XYStatus *)status{
    XYComposeViewController *composeVC = [[XYComposeViewController alloc] init];
    composeVC.title = @"发评论";
    composeVC.commentStatus = YES;
    composeVC.status = status;
    
    composeVC.repostPlacehold = @"写评论...";
    
    
    XYMainNavigationController *mainNav = [[XYMainNavigationController alloc] initWithRootViewController:composeVC];
    [self presentViewController:mainNav animated:YES completion:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
