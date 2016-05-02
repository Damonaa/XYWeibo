//
//  XYNewFeatureCell.h
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYNewFeatureCell : UICollectionViewCell
/**
 *  cell图片
 */
@property (nonatomic, weak) UIImage *image;
/**
 *  根据cell的indexPath决定是否显示按钮
 *
 *  @param indexPath indexpath
 *  @param count     cell的总数
 */
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
