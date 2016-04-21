//
//  XYComposeViewController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/22.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposeViewController.h"
#import "XYTextView.h"
#import "XYComposeToolBar.h"
#import "XYComposePhotosView.h"
#import "XYComposeTool.h"
#import "MBProgressHUD+CZ.h"

@interface XYComposeViewController ()<XYComposeToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) XYTextView *textView;

@property (nonatomic, weak) XYComposeToolBar *toolBar;

@property (nonatomic, weak) XYComposePhotosView *photosView;

@property (nonatomic, weak) UIBarButtonItem *sendBarBtn;

/**
 *  选取的图片们
 */
@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation XYComposeViewController

- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加导航条上的按钮
    [self setupNavItems];
    //添加textView
    [self setupTextField];
    
    [self.textView becomeFirstResponder];
    
    //添加工具栏
    [self setupToolBar];
    
    //添加图片Views
    [self setupPhotosView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 监听键盘弹出消失
- (void)keyboardWillChange:(NSNotification *)noti{
//    NSLog(@"%@", noti.userInfo);
    
    CGRect endRect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat move = XYScreenH - endRect.origin.y;
    
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -move);
    }];
}
#pragma mark - 添加图片Views
- (void)setupPhotosView{
    XYComposePhotosView *photosView = [[XYComposePhotosView alloc] initWithFrame:CGRectMake(0, 70, XYScreenW, XYScreenW)];
    self.photosView = photosView;
    [self.textView addSubview:photosView];
}

#pragma mark - 添加导航条上的按钮
- (void)setupNavItems{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    
    //右边发送按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    rightBtn.titleLabel.font = XYNavItemFont;
    rightBtn.enabled = NO;
    [rightBtn addTarget:self action:@selector(sendCompose) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    
    UIBarButtonItem *sendBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = sendBarBtn;
    self.sendBarBtn = sendBarBtn;
    self.sendBarBtn.enabled = NO;
}
#pragma mark - 发送微博
- (void)sendCompose{
    if (self.photos.count) {
        //发图片
        [self sendPhotos];
    }else{
        //发文本
        [self sendText];
    }
}
//发图片
- (void)sendPhotos{
    
    NSString *status = self.textView.text.length == 0 ? @"分享图片" :self.textView.text;
    UIImage *photo = self.photos[0];
    
    [XYComposeTool sendPhotosComposeWithStatus:status photo:photo success:^{
        [MBProgressHUD showSuccess:@"发送成功"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"sendPhotosCompose error %@", error);
    }];
}

//发文本
- (void)sendText{
    [XYComposeTool sendComposeWithStatus:self.textView.text success:^{
        [MBProgressHUD showSuccess:@"发送成功"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"error");
    }];
}
#pragma mark - 点击取消按钮，返回HomeVC
- (void)cancelClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 添加textView
- (void)setupTextField{
    XYTextView *textView = [[XYTextView alloc] init];
    self.textView = textView;
    [self.view addSubview:textView];
    textView.placeHold = @"what are u 想啥呢";
    textView.font = [UIFont systemFontOfSize:13];
    textView.frame = self.view.bounds;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    
}

#pragma mark - 输入文本发生变化
- (void)textViewTextDidChange:(NSNotification *)noti{
//    NSLog(@"%@", noti.userInfo);
    if (self.textView.text.length == 0) {
        self.textView.hidenPlaceHoldLabel = NO;
        self.sendBarBtn.enabled = NO;
    }else{
        self.textView.hidenPlaceHoldLabel = YES;
        self.sendBarBtn.enabled = YES;
    }
    
    //限定输入字数
    if (self.textView.text.length > 140) {
        self.textView.text = [self.textView.text substringToIndex:140];
    }

}
#pragma mark - 添加工具栏
- (void)setupToolBar{
    XYComposeToolBar *toolBar = [[XYComposeToolBar alloc] init];
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    toolBar.frame = CGRectMake(0, XYScreenH - 33, XYScreenW, 33);
    
    toolBar.delegate = self;
    
}
#pragma mark - XYComposeToolBarDelegate
- (void)composeToolBar:(XYComposeToolBar *)composeToolBar toolBtn:(UIButton *)button{
    if (button.tag == 0) {
        //选取照片
        [self choosePhoto];
        
        if (self.photos.count == 8) {
            button.enabled = NO;
        }
        
    }else if (button.tag == 4){
        
        if (self.textView.isFirstResponder) {
            [self.textView resignFirstResponder];
        }else{
            [self.textView becomeFirstResponder];
        }
        
//        [self.view endEditing:YES];
    }
}
#pragma mark - 选取照片
- (void)choosePhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

/**
 *  {
 UIImagePickerControllerMediaType = "public.image";
 UIImagePickerControllerOriginalImage = "<UIImage: 0x7f8c9aa6c030> size {640, 1136} orientation 0 scale 1.000000";
 UIImagePickerControllerReferenceURL = "assets-library://asset/asset.JPG?id=D8C1F73F-BB87-41E6-B667-8145D82989BE&ext=JPG";
 }
 */
//UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    NSLog(@"%@", info);
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.sendBarBtn.enabled = YES;
    
    //取得图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //为photosView设置图片
    UIImageView *imageView = self.photosView.subviews[self.photos.count];
    imageView.image = image;
    //添加到数组中
    [self.photos addObject:image];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
