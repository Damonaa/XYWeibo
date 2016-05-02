//
//  XYStatusCell.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusCell.h"
#import "XYOriginalView.h"
#import "XYRetweetedView.h"
#import "XYToolBarView.h"
#import "XYStatusFrame.h"

@interface XYStatusCell ()

/**
 *  原创视图
 */
@property (nonatomic, weak) XYOriginalView *originalView;
/**
 *  转发视图
 */
@property (nonatomic, weak) XYRetweetedView *retweetedView;
/**
 *  工具栏视图
 */
@property (nonatomic, weak) XYToolBarView *toolBarView;
@end

@implementation XYStatusCell

/**
 *  初始化创建cell
 */
+ (instancetype)statusCellWithTableView:(UITableView *)tableView{
    static NSString *reusedID = @"statusCell";
    XYStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[XYStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }

    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self setupAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//添加子控件
- (void)setupAllChildView{
    XYOriginalView *originalView = [[XYOriginalView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    XYRetweetedView *retweetedView = [[XYRetweetedView alloc] init];
    [self.contentView addSubview:retweetedView];
    self.retweetedView = retweetedView;
    
    XYToolBarView *toolBarView = [[XYToolBarView alloc] init];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
    
    
}

//赋值
- (void)setStatusFrame:(XYStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    self.originalView.frame = statusFrame.originalViewFrame;
    self.originalView.statusFrame = statusFrame;
    
    self.retweetedView.frame = statusFrame.retweetedViewFrame;
    self.retweetedView.statusFrame = statusFrame;
    
    self.toolBarView.frame = statusFrame.toolBarFrame;
    self.toolBarView.statusFrame = statusFrame;
}
@end
