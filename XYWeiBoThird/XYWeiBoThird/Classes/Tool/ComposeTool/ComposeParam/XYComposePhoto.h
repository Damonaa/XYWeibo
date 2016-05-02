//
//  XYComposePhoto.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/28.
//  Copyright © 2016年 李小亚. All rights reserved.
// AFN 上传文件需要的参数

#import <Foundation/Foundation.h>

@interface XYComposePhoto : NSObject
// [formData appendPartWithFileData:data name:@"pic" fileName:@"image.jpg" mimeType:@"image/jpg"];
/**
 *  需要上传的文件
 */
@property (nonatomic, strong) NSData *data;

/**
 *  需要上传的文件名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器后的文件名
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mineType;
@end
