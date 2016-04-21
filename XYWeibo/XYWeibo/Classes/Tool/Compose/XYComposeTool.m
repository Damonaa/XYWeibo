//
//  XYComposeTool.m
//  Weibo
//
//  Created by 李小亚 on 16/3/23.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYComposeTool.h"
#import "XYComposeTextParam.h"
#import "XYHttpTool.h"
#import "MJExtension.h"
#import "XYComposePhotosParam.h"

@implementation XYComposeTool

/**
 *  发送文本微博
 *
 *  @param ststus  文本内容
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendComposeWithStatus:(NSString *)ststus success:(void (^)())success failure:(void (^)(NSError *error))failure{
 
    XYComposeTextParam *param = [XYComposeTextParam baseParam];
    param.status = ststus;
    
    
    [XYHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        
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
 *  发送带图片的微博
 *
 *  @param ststus  文本内容
 *  @param photo   需要发送的图片
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)sendPhotosComposeWithStatus:(NSString *)ststus photo:(UIImage *)photo success:(void (^)())success failure:(void (^)(NSError *error))failure{
    XYComposeTextParam *param = [XYComposeTextParam baseParam];
    param.status = ststus;
    
    XYComposePhotosParam *photoParam = [[XYComposePhotosParam alloc] init];
    photoParam.fileData = UIImagePNGRepresentation(photo);
    photoParam.name = @"pic";
    photoParam.fileName = @"image.jpg";
    photoParam.mineType = @"image/jpg.";
    
    
    [XYHttpTool uploadWithUrlStr:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues composePhotos:photoParam success:^(id responseObject) {
        
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
