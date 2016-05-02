//
//  XYComposeTool.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposeTool.h"
#import "XYHttpTool.h"
#import "XYComposeParam.h"
#import "XYComposePhoto.h"
#import "XYRepostParam.h"
#import "XYCommentParam.h"

@implementation XYComposeTool

/**
 *  发送文字微博
 *
 *  @param status  文字内容
 *  @param visible 可见性 （可选）
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendStatusWithStatus:(NSString *)status visible:(NSNumber *)visible success:(void (^)())success failure:(void (^)(NSError *error))failure{
    
    XYComposeParam *param = [XYComposeParam baseParam];
    param.status = status;
    
    [XYHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.mj_keyValues success:^(id responseObject) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

/**
 *  发送带文字的微博
 *
 *  @param status  文字内容
 *  @param photo   图片
 *  @param visible 可见性 （可选）
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendPhotosWithStatus:(NSString *)status photo:(UIImage *)photo visible:(NSNumber *)visible success:(void (^)())success failure:(void (^)(NSError *error))failure{
    
    XYComposeParam *param = [XYComposeParam baseParam];
    param.status = status;
    
    XYComposePhoto *composePhoto = [[XYComposePhoto alloc] init];
    composePhoto.data = UIImagePNGRepresentation(photo);
    //必须是pic！
    composePhoto.name = @"pic";
    composePhoto.fileName = @"imageaa.jpg";
    composePhoto.mineType = @"image/jpg";
    
    
    [XYHttpTool POSTData:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.mj_keyValues composePhoto:composePhoto success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  转发无文字的微博
 *
 *  @param status  文本内容
 *  @param idStr   转发微博的idstr
 *  @param comment 是否评论
 *  @param visible 可见性
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)repostStatusWithStatus:(NSString *)status idStr:(NSString *)idStr comment:(int)comment visible:(NSNumber *)visible success:(void (^)())success failure:(void (^)(NSError *error))failure{
    XYRepostParam *repostParam = [XYRepostParam baseParam];
    repostParam.id = [idStr integerValue];
    repostParam.status = status;
    repostParam.is_comment = comment;
    
    [XYHttpTool POST:@"https://api.weibo.com/2/statuses/repost.json" parameters:repostParam.mj_keyValues success:^(id responseObject) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

/**
 *  评论微博
 *
 *  @param comment     评论的内容，不可为空
 *  @param idStr       评论的微博的id
 *  @param comment_ori 当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0
 *  @param success     成功回调
 *  @param failure     失败回调
 */
+ (void)commentStatusWithComment:(NSString *)comment idStr:(NSString *)idStr comment_ori:(int)comment_ori success:(void (^)())success failure:(void (^)(NSError *error))failure{
    XYCommentParam *commentParam = [XYCommentParam baseParam];
    commentParam.comment = comment;
    commentParam.id = [idStr integerValue];
    commentParam.comment_ori = comment_ori;
    
    [XYHttpTool POST:@"https://api.weibo.com/2/comments/create.json" parameters:commentParam.mj_keyValues success:^(id responseObject) {
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
