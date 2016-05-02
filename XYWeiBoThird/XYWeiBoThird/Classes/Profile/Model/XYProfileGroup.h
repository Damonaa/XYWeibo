//
//  XYProfileGroup.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/30.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYProfileGroup : NSObject
/**
 *  头标题
 */
@property (nonatomic, copy) NSString *headerTitle;
/**
 *  尾标题
 */
@property (nonatomic, copy) NSString *footerTitle;

/**
 *  存放一组的XYProfileItem
 */
@property (nonatomic, strong) NSArray *groupItems;

@end
