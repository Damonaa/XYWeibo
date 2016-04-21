//
//  XYHomeViewController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/18.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYHomeViewController.h"
#import "UIBarButtonItem+XYCategory.h"
#import "XYTitleButton.h"
#import "XYPopMenuView.h"
#import "XYCoverView.h"
#import "XYPopMenuController.h"

#import "XYAccountTool.h"
#import "XYAccountResult.h"

#import "XYStatusTool.h"
#import "XYStatus.h"
#import "XYUser.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "XYUserTool.h"

#import "XYStatusFrame.h"
#import "XYStatusCell.h"

@interface XYHomeViewController ()<XYCoverViewDelegate>
/**
 *  标题按钮
 */
@property (nonatomic, weak) UIButton *titleBtn;
/**
 *  标题按钮下的菜单栏
 */
@property (nonatomic, strong) XYPopMenuController *popMenuCtr;

/**
 *  微博信息（XYStatus）
 */
//@property (nonatomic, strong) NSMutableArray *statuses;
/**
 *  微博cell信息 （XYStatusFrame）
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;
@end

@implementation XYHomeViewController

#pragma mark - 懒加载
//- (NSMutableArray *)statuses{
//    if (!_statuses) {
//        _statuses = [NSMutableArray array];
//    }
//    return _statuses;
//}

- (NSMutableArray *)statusFrames{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (XYPopMenuController *)popMenuCtr{
    if (!_popMenuCtr) {
        _popMenuCtr = [[XYPopMenuController alloc] init];
    }
    return _popMenuCtr;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏上的按钮
    [self setupNavigationItem];
    
    //加载新的微博数据
//    [self loadNewStatuses];

    //下拉刷新更新的数据
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatuses)];
    
    //上拉加载更多
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatuses)];
    //设置标题按钮的text
    [self setupNameWithTitleBtn];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithWhite:0.895 alpha:1.000];
}


#pragma mark - 设置标题按钮的text
- (void)setupNameWithTitleBtn{
    [XYUserTool userInfoWithSuccess:^(XYUser *user) {
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
        
        //保存用户的昵称
        XYAccountResult *account = [XYAccountTool account];
        account.name = user.name;
        //归档 沙盒
        [XYAccountTool saveAccountWith:account];
        
    } failure:^(NSError *error) {
        NSLog(@"userInfo error: %@", error);
    }];
}


#pragma mark - 加载新的微博数据
- (void)loadNewStatuses{
    //设置since_id
    NSString *sinceIdStr;
    if (self.statusFrames.count) {
        XYStatusFrame *statusFrame = [self.statusFrames firstObject];
        XYStatus *status = statusFrame.status;
        sinceIdStr = status.idstr;
    }
    
    [XYStatusTool newStatusesWithSinceID:sinceIdStr success:^(NSArray *statuses) {
        //停止刷新
        [self.tableView headerEndRefreshing];
        
        //添加label 提示更新的微博数
        [self showNewStatusesWithCount:(NSInteger)statuses.count];
        
        NSMutableArray *newM = [NSMutableArray array];
        for (XYStatus *status in statuses) {
            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
            statusFrame.status = status;
//            NSLog(@"%@", status);
            [newM addObject:statusFrame];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newM.count)];
        [self.statusFrames insertObjects:newM atIndexes:indexSet];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        //停止刷新
        [self.tableView headerEndRefreshing];
        NSLog(@"loadNewStatuses error %@", error);
    }];
}
#pragma mark - 添加label 提示更新的微博数
- (void)showNewStatusesWithCount:(NSInteger)count{
    
    if (count == 0) {
        return;
    }
    //设置label的属性
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"更新了%ld条微博",count];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor orangeColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    label.alpha = 0;
    
//    CGFloat labelY = self.navigationController.navigationBar.frame.size.height - 33;
    label.frame = CGRectMake(0, 33, XYScreenW, 33);
    
    //添加到控制器上
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //添加动画
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1;
        label.transform = CGAffineTransformMakeTranslation(0, 33);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.transform = CGAffineTransformIdentity;
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];

        }];
    }];
    
}
#pragma mark - 加载更多旧的微博数据
- (void)loadMoreStatuses{
    //设置max_id
    NSString *maxIdStr;
    if (self.statusFrames.count) {
        maxIdStr = [[[self.statusFrames lastObject] status] idstr];
        long long max_id = [maxIdStr longLongValue];
        maxIdStr = [NSString stringWithFormat:@"%lld", max_id - 1];
    }
    //请求更多旧数据
    [XYStatusTool moreStatusesWithMaxID:maxIdStr success:^(NSArray *statuses) {
        //停止刷新
        [self.tableView footerEndRefreshing];
        /**
         * 将获取到的更多的微博插入到self.statuses
         */
        NSMutableArray *moreM = [NSMutableArray array];
        for (XYStatus *status in statuses) {
            XYStatusFrame *statusFrame = [[XYStatusFrame alloc] init];
            statusFrame.status = status;
            [moreM addObject:statusFrame];
        }
        [self.statusFrames addObjectsFromArray:moreM];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        //停止刷新
        [self.tableView footerEndRefreshing];
        NSLog(@"moreStatuses error %@", error);
    }];
    
}

//下拉刷新加载微博数据
- (void)refreshStatus{
    [self.tableView headerBeginRefreshing];
}
#pragma mark - UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYStatusCell *cell = [XYStatusCell statusCellWithTableView:tableView];
    cell.statusesFrame = self.statusFrames[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.rowHeight;
}

#pragma mark - 设置导航栏上的按钮
- (void)setupNavigationItem{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:[UIImage imageNamed:@"navigationbar_friendsearch"]  highligetedImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(leftClick) events:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:[UIImage imageNamed:@"navigationbar_pop"] highligetedImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(rightClick) events:UIControlEventTouchUpInside];
    
    XYTitleButton *titleBtn = [XYTitleButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn = titleBtn;
    //设置title
    XYAccountResult *account = [XYAccountTool account];
    NSString *titleName = account.name ? : @"首页";
    [titleBtn setTitle:titleName forState:UIControlStateNormal];

    titleBtn.adjustsImageWhenHighlighted = NO;
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}
#pragma mark - 点击头标题响应事件
- (void)titleBtnClick:(UIButton *)button{
    button.selected = !button.selected;
    //添加蒙版
    XYCoverView *cover = [XYCoverView show];
    cover.delegate = self;
    
    
    CGFloat popW = 200;
    CGFloat popH = popW;
    CGFloat popX = (self.view.width - popW) / 2;
    CGFloat popY = 55;
    
   XYPopMenuView *popMenuVew = [XYPopMenuView popMenuInRect:CGRectMake(popX, popY, popW, popH)];
    popMenuVew.contentView = self.popMenuCtr.view;
     
}

- (void)coverViewClick:(XYCoverView *)coverView{
    
    [XYPopMenuView hiden];
    self.titleBtn.selected = NO;
    
    NSLog(@"%s", __func__);
}
- (void)leftClick{
    NSLog(@"%s", __func__);
}

- (void)rightClick{
    NSLog(@"%s", __func__);
}

//移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
