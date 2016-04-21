//
//  XYComposePhotosParam.h
//  Weibo
//
//  Created by 李小亚 on 16/3/23.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYComposePhotosParam : NSObject


/**
 *  需要上传的文件 二进制
 */
@property (nonatomic, strong) NSData *fileData;

/**
 *  文件名 ？？
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的名称
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  上传的文件的类型
 */
@property (nonatomic, copy) NSString *mineType;

@end
