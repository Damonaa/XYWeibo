//
//  XYDiscoverViewController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYDiscoverViewController.h"
#import "UIImage+XYCategory.h"

@interface XYDiscoverViewController ()

@property (nonatomic, weak) UITextField *searchField;
@end

@implementation XYDiscoverViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupTitleSearchView];
}

//设置标题搜索框
- (void)setupTitleSearchView{
    
    UITextField *searchField = [[UITextField alloc] init];
    self.searchField = searchField;
    
    searchField.background = [UIImage imageStretchableWithImage:[UIImage imageNamed:@"searchbar_textfield_background"]];
    searchField.placeholder = @"搜......";
    searchField.font = [UIFont systemFontOfSize:12];
    UIImageView *leftIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    leftIV.contentMode = UIViewContentModeCenter;
    leftIV.width += 10;
    searchField.leftView = leftIV;
    searchField.leftViewMode = UITextFieldViewModeAlways;
 
    searchField.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 10, 33);
    
    self.navigationItem.titleView = searchField;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
    [self.searchField resignFirstResponder];
}
@end
