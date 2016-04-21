//
//  XYStatusFrame.m
//  Weibo
//
//  Created by 李小亚 on 16/3/21.
//  Copyright © 2016年 李小亚. All rights reserved.
//



#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"

@implementation XYStatusFrame

//计算UIframe
- (void)setStatus:(XYStatus *)status{
    _status = status;
    
    //计算原创微博的frame
    [self setupOriginalViewFrameWithStatus:status];
    
    CGFloat toolY = CGRectGetMaxY(_originalViewFrame);
    
    //若有转发微博 计算转发微博的frame
    if (status.retweeted_status) {
        [self setupRetweetlViewFrameWithStatus:status.retweeted_status];
        toolY = CGRectGetMaxY(_retweetViewFrame);
    }
    
    //工具栏的farme
    _toolBarFrame = CGRectMake(0, toolY, XYScreenW, 35);
    
    _rowHeight = CGRectGetMaxY(_toolBarFrame);
}

//计算原创微博的frame
- (void)setupOriginalViewFrameWithStatus:(XYStatus *)status{
    //作者icon
    CGFloat margin = XYMarginCell;
    CGFloat iconXY = margin + 5;
    CGFloat iconWH = 35;
    self.originalIconFrame = CGRectMake(iconXY, iconXY, iconWH, iconWH);
    
    //昵称
    CGFloat nameW = [status.user.name sizeWithAttributes:@{NSFontAttributeName:XYOriginalNameFont}].width;
    CGFloat nameH = 10;
    CGFloat nameX = CGRectGetMaxX(self.originalIconFrame) + margin;
    CGFloat nameY = iconXY;
    self.originalNameFrame = CGRectMake(nameX, nameY, nameW, nameH);
    
    //vip
    CGFloat vipWH = 10;
    CGFloat vipX = CGRectGetMaxX(self.originalNameFrame) + margin;
    CGFloat vipY = nameY;
    self.originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    
//    //create time 随着时间的变化， self.originalCreateTimeFrame的大小会变化
//                   这里的值不在变化，在View中设置frame
//    CGFloat timeW = [status.created_at sizeWithAttributes:@{NSFontAttributeName: XYOriginalTimeFont}].width;
//    CGFloat timeH = 10;
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.originalNameFrame) + margin;
//    self.originalCreateTimeFrame = CGRectMake(timeX, timeY, timeW, timeH);
//    
//    //source
//    CGFloat sourceW = [status.source sizeWithAttributes:@{NSFontAttributeName:XYOriginalTimeFont}].width;
//    CGFloat sourceH = timeH;
//    CGFloat sourceX = CGRectGetMaxX(self.originalCreateTimeFrame) + margin;
//    CGFloat sourceY = timeY;
//    self.originalSourceFrame = CGRectMake(sourceX, sourceY, sourceW, sourceH);
    
    //text
    CGFloat textW = XYScreenW - margin * 2;
    CGSize maxSize = CGSizeMake(textW, MAXFLOAT);
    CGSize textSize = [status.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: XYOriginalTextFont} context:nil].size;
    CGFloat textX = margin;
    CGFloat textY = CGRectGetMaxY(self.originalIconFrame) + margin;
    self.originalTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat originalH = CGRectGetMaxY(self.originalTextFrame) + margin;
//    self.originalViewFrame = CGRectMake(0, 10, XYScreenW, originalH);
    
    //photos
    if (status.pic_urls.count) {
        CGSize photosSize = [self photosSizeWithCount:status.pic_urls.count];
        CGFloat photoX = margin;
        CGFloat photoY = CGRectGetMaxY(self.originalTextFrame) + margin;
        self.originalPhotoFrame = (CGRect){{photoX, photoY}, photosSize};
        
        originalH = CGRectGetMaxY(self.originalPhotoFrame) + margin;
        
    }

    self.originalViewFrame = CGRectMake(0, 10, XYScreenW, originalH);
}

//计算转发微博的frame
- (void)setupRetweetlViewFrameWithStatus:(XYStatus *)status{
    //name
    CGFloat nameXY = XYMarginCell;
    CGFloat nameW = [status.user.name sizeWithAttributes:@{NSFontAttributeName: XYRetweetNameFont}].width;
    CGFloat nameH = 10;
    self.retweetNameFrame = CGRectMake(nameXY, nameXY, nameW, nameH);
    
    //text
    CGFloat textW = XYScreenW - XYMarginCell * 2;
    CGSize maxSize = CGSizeMake(textW, MAXFLOAT);
    CGSize textSize = [status.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: XYRetweetTextFont} context:nil].size;
    CGFloat textX = XYMarginCell;
    CGFloat textY = CGRectGetMaxY(self.retweetNameFrame) + XYMarginCell;
    self.retweetTextFrame = (CGRect){{textX, textY}, textSize};
    
    CGFloat retweetH = CGRectGetMaxY(self.retweetTextFrame) + XYMarginCell;
    
    //photos
    if (status.pic_urls.count) {
        CGSize photosSize = [self photosSizeWithCount:status.pic_urls.count];
        CGFloat photoX = XYMarginCell;
        CGFloat photoY = CGRectGetMaxY(self.retweetTextFrame) + XYMarginCell;
        self.retweetPhotosFrame = (CGRect){{photoX, photoY}, photosSize};
        
        retweetH = CGRectGetMaxY(self.retweetPhotosFrame) + XYMarginCell;
    }
    
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(self.originalViewFrame);
    CGFloat retweetW = XYScreenW;
    self.retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}
/**
 *  计算图片所占的size
 *
 *  @param count 图片个数
 *
 *  @return 图片所占的size
 */
- (CGSize)photosSizeWithCount:(NSInteger)count{
    NSInteger colume = count == 4 ? 2 : 3;
    NSInteger row = (count - 1) / colume + 1;
    
    CGFloat photoWH = 70 + XYMarginCell;
    return CGSizeMake(colume * photoWH, row * photoWH);
}
@end
