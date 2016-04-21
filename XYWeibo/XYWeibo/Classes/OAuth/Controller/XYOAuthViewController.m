//
//  XYOAuthViewController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//oauth授权
//1， 请求授权  https://api.weibo.com/oauth2/authorize?client_id=2539724958&redirect_uri=https://www.baidu.com
//2，跳转到回调页面 百度 获取 code  https://www.baidu.com/?code=583d4d6917f88d6a2e7cbe292a046168 //每一次的code都是不同的
//3，获取授权 access_token 是固定的，保存到沙盒
/**
 *   "access_token" = "2.00NEQu4CmT7slC223af57f600pFkgv";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 2185529525;
 */

#import "XYOAuthViewController.h"
#import "MBProgressHUD+CZ.h"
#import "XYRootVCTool.h"
#import "XYAccountResult.h"
#import "XYAccountTool.h"

@interface XYOAuthViewController ()<UIWebViewDelegate>

@end
@implementation XYOAuthViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    //创建UIWebView
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    
    
    NSString *basUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = XYClient_id;
    NSString *redirect_uri = XYRedirect_Uri;
    
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", basUrl, client_id, redirect_uri];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:5];
    
    [webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"玩命加载...."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"request %@", request);
    
    //截取code
    NSString *urlStr = request.URL.absoluteString;
    
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {//取到了包含code的URL
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
//        NSLog(@"code: %@", code);
//        3，获取授权 access_token
        [self accessTokenWithCode:code];

        return NO;
    }
    
    return YES;
}

//3，获取授权 access_token
- (void)accessTokenWithCode:(NSString *)code{
    [XYAccountTool getAccessTokenWithCode:code success:^{
        //进入主控制器
        [XYRootVCTool setupRootVCWithWindow:XYKeyWindow];
        
    } failure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}
@end
