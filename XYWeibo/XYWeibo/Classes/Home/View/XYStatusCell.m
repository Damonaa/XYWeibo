//
//  XYStatusCell.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusCell.h"
#import "XYOriginalView.h"
#import "XYRetweetView.h"
#import "XYToolBarView.h"
#import "XYStatusFrame.h"

@interface XYStatusCell ()
/**
 *  原创微博 View
 */
@property (nonatomic, weak) XYOriginalView *originalView;
/**
 *  转发微博的View
 */
@property (nonatomic, weak) XYRetweetView *retweetView;
/**
 *  工具栏的View
 */
@property (nonatomic, weak) XYToolBarView *toolBarView;

@end

@implementation XYStatusCell
/**
 *  初始化自定义的cell
 */
+ (instancetype)statusCellWithTableView:(UITableView *)tableView{
    static NSString *reuseIdentifier = @"statusCell";
    XYStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

/**
 *  重新自定义布局cell的控件
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        //设置子控件
        [self setupAllChildView];
    }
    
    return self;
}

//设置子控件
- (void)setupAllChildView{
    //原创微博 View
    XYOriginalView *originalView = [[XYOriginalView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    //转发微博View
    XYRetweetView *retweetView = [[XYRetweetView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    //工具栏
    XYToolBarView *toolBarView = [[XYToolBarView alloc] init];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
}
/**
 *  布局cell中ui的位置 并赋值
 */
- (void)setStatusesFrame:(XYStatusFrame *)statusesFrame{
    _statusesFrame = statusesFrame;
    
    self.originalView.statusFrame = statusesFrame;
    self.originalView.frame = statusesFrame.originalViewFrame;
    
    self.retweetView.statusFrame = statusesFrame;
    self.retweetView.frame = statusesFrame.retweetViewFrame;
    
    self.toolBarView.statusFrame = statusesFrame;
    self.toolBarView.frame = statusesFrame.toolBarFrame;
}
@end
