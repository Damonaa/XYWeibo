//
//  XYOneVC.m
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYOneVC.h"
#import "XYTwoVC.h"
#import "UIBarButtonItem+XYCategory.h"

@implementation XYOneVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"One";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:[UIImage imageNamed:@"navigationbar_back"] highligetedImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(leftBarButtonClick) events:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithNormalImage:[UIImage imageNamed:@"navigationbar_more"] highligetedImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(rightBarButtonClick) events:UIControlEventTouchUpInside];
}


- (void)leftBarButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick{
    XYTwoVC *twoVC = [[XYTwoVC alloc] init];
    [self.navigationController pushViewController:twoVC animated:YES];
}
@end
