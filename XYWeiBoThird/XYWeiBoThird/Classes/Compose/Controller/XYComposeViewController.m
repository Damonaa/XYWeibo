//
//  XYComposeViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposeViewController.h"
#import "XYTextView.h"
#import "XYComposeToolBarView.h"
#import "XYComposePhotosView.h"
#import "XYComposeTool.h"
#import "XYStatus.h"
#import "XYUser.h"
#import "XYRepostView.h"

@interface XYComposeViewController ()<XYComposeToolBarViewDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/**
 *  文本输入栏
 */
@property (nonatomic, weak) XYTextView *textView;
/**
 *  工具栏
 */
@property (nonatomic, weak) XYComposeToolBarView *toolBarView;
/**
 *  发送按钮
 */
@property (nonatomic, weak) UIButton *rightBtn;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
/**
 *  图片视图
 */
@property (nonatomic, weak) XYComposePhotosView *composePhotosView;
/**
 *  转发微博的预览视图
 */
@property (nonatomic, weak) XYRepostView *repostView;

/**
 *  存放选中的图片
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = rightBtn;
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    rightBtn.enabled = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    //添加子控件
    [self setupChildView];
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//取消发送
- (void)leftBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//发微博
- (void)rightBtnClick{
#warning 有时评论和转发会失败 why！！！！
    if (self.isRepostStatus) {//是转发微博(文字，无图片)
        NSString *repostName = [NSString stringWithFormat:@"@%@", _status.user.name];
        
        NSString *status = self.textView.text.length > 0 ? self.textView.text : repostName;
        [XYComposeTool repostStatusWithStatus:status idStr:_status.idstr comment:1 visible:0 success:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            XYLog(@"%@", error);
        }];
        return;
    }
    
    if (self.isCommentStatus) {//是评论微博(文字，无图片)
        [XYComposeTool commentStatusWithComment:self.textView.text idStr:_status.idstr comment_ori:0 success:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            XYLog(@"%@", error);
        }];
        return;
    }
    
    if (self.photos.count) {//有图片，上传图片
        
        NSString *status = self.textView.text.length > 0 ? self.textView.text : @"分享图片";
        
        [XYComposeTool sendPhotosWithStatus:status photo:self.photos[0] visible:0 success:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSError *error) {
            XYLog(@"%@", error);
        }];
        
    }else{//无图，发文字
       [XYComposeTool sendStatusWithStatus:self.textView.text visible:0 success:^{
           
           [self dismissViewControllerAnimated:YES completion:nil];
           
       } failure:^(NSError *error) {
           XYLog(@"%@", error);
       }];
    }
    
}

#pragma mark - 监听键盘弹出
- (void)keyboardWillShow:(NSNotification *)noti{

    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect lastRect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat moveY = lastRect.origin.y - XYScreenHeight;
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBarView.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
}
#pragma mark - 添加子控件
- (void)setupChildView{
    //文本
    XYTextView *textView = [[XYTextView alloc] init];
    [self.view addSubview:textView];
    self.textView = textView;
    
    if (self.repostPlacehold) {//如果是转发的原创微博
        textView.placeHolder = _repostPlacehold;
    }else{
        textView.placeHolder = @"分享新鲜事...";
    }
    if (self.repostText) {//如果是转发的转发微博
        textView.text = _repostText;
        textView.hiddenPlaceHolder = YES;
    }
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    textView.frame = CGRectMake(0, 5, XYScreenWidth, 150);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name:UITextViewTextDidChangeNotification object:nil];
    //弹出键盘，成为第一响应
//    [textView becomeFirstResponder];
    //图片
    XYComposePhotosView *composePhotosView = [[XYComposePhotosView alloc] init];
    [self.view addSubview:composePhotosView];
    self.composePhotosView = composePhotosView;
    composePhotosView.frame = CGRectMake(0, CGRectGetMaxY(textView.frame) + 10, XYScreenWidth, 0);
    
    if (self.isRepostStatus) {//是转发的微博
        XYRepostView *repostView = [[XYRepostView alloc] init];
        [self.view addSubview:repostView];
        self.repostView = repostView;
        repostView.frame = CGRectMake(5, CGRectGetMaxY(composePhotosView.frame) + 5, XYScreenWidth - 10, 70);
        repostView.status = _status;
    }
    
    //工具栏
    XYComposeToolBarView *toolBarView = [[XYComposeToolBarView alloc] init];
    [self.view addSubview:toolBarView];
    self.toolBarView = toolBarView;
    toolBarView.delegate = self;
    toolBarView.frame = CGRectMake(0, XYScreenHeight - 35, XYScreenWidth, 35);
    
}

//监听textView内容的变化
- (void)textViewTextDidChange{
    if (self.textView.text.length > 0) {
        //隐藏占位符，启用发送按钮
        self.textView.hiddenPlaceHolder = YES;
        self.rightBtn.enabled = YES;
    }else{
        self.textView.hiddenPlaceHolder = NO;
        self.rightBtn.enabled = NO;
    }
}

#pragma mark - XYComposeToolBarViewDelegate
- (void)toolBarView:(XYComposeToolBarView *)toolBarView didClickBtnAtIndex:(NSInteger)index{
    if (index == 0) {//打开相册
        
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        //相册
        UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:_imagePicker animated:YES completion:nil];
        }];
        [alertCtrl addAction:album];
        
        //相机
        UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.imagePicker presentViewController:_imagePicker animated:YES completion:nil];
        }];
        [alertCtrl addAction:camera];
        //取消
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertCtrl addAction:cancel];
        
        [self presentViewController:alertCtrl animated:YES completion:nil];
        
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
//    XYLog(@"%@", info);

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImageView *imageView = self.composePhotosView.subviews[self.photos.count];
    imageView.image = image;
    
    [self.photos addObject:image];
    self.rightBtn.enabled = YES;
    
    CGFloat rowHeight = XYScreenWidth / 3;
    
    self.composePhotosView.height = ((_photos.count - 1) / 3 + 1) * rowHeight;
    
    if (self.isRepostStatus) {
        self.repostView.y = CGRectGetMaxY(_composePhotosView.frame) + 5;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate
//隐藏键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.textView.isFirstResponder) {
        [self.textView resignFirstResponder];
    }
}
@end
