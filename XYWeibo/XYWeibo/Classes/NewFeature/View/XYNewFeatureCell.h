//
//  XYNewFeatureCell.h
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYNewFeatureCell : UICollectionViewCell


/**
 *  cell的图片
 */
@property (nonatomic, weak) UIImage *image;


/**
 *  判断当前的cell是第几个cell
 *  来决定是否展示按钮
 *  @param indexPath 当前的cell
 *  @param count     总的cell数
 */
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
