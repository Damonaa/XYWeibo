//
//  XYStatusFrame.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatusFrame.h"
#import "XYStatus.h"
#import "XYUser.h"

@implementation XYStatusFrame

- (void)setStatus:(XYStatus *)status{
    _status = status;
    //计算原创微博的frame
    [self setupOriginalStatusFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status) {//有转发微博
        [self setupRetweetedStatusFrame];
        toolBarY = CGRectGetMaxY(_retweetedViewFrame);
    }
    _toolBarFrame = CGRectMake(0, toolBarY, XYScreenWidth, 35);
    //行高
    _rowHeight = CGRectGetMaxY(_toolBarFrame);
}

//计算原创微博的frame
- (void)setupOriginalStatusFrame{
    CGFloat margin = XYStatusCellMargin;
    //icon
    CGFloat iconWH = 35;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    
    _originalIconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    //name
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + margin;
    CGFloat nameY = iconY;
    CGSize nameSize = [_status.user.name sizeWithAttributes:@{NSFontAttributeName: XYStatusCellNameFont}];
    _originalNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //vip
    CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + margin;
    CGFloat vipY = iconY;
    CGFloat vipWH = 10;
    _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    
//    //time
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + margin;
//    CGSize timeSize = [_status.created_at sizeWithAttributes:@{NSFontAttributeName: XYStatusCellTimeFont}];
//   
//    _originalTimeFrame = (CGRect){{timeX, timeY}, timeSize};
//    
//    //source
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + margin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithAttributes:@{NSFontAttributeName: XYStatusCellTimeFont}];
//    _originalSourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //text
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + margin;
    
    CGSize textSize = [self textSizeWithText:_status.text];
    _originalTextFrame = (CGRect){{textX, textY},textSize};
    
    
    CGFloat originalH = CGRectGetMaxY(_originalTextFrame) + margin;
    //photos
    if (_status.pic_urls.count) {
        CGFloat photosX = margin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + margin;
        CGSize photosSize = [self photoSizeWithCount:_status.pic_urls.count];
        _originalPhotosFrame = (CGRect){{photosX, photosY},photosSize};
        
        originalH = CGRectGetMaxY(_originalPhotosFrame) + margin;
    }
    
    _originalViewFrame = CGRectMake(0, 10, XYScreenWidth, originalH);
}
//计算转发微博的frame
- (void)setupRetweetedStatusFrame{
    XYStatus *status = _status.retweeted_status;
    
    //name
    CGFloat margin = XYStatusCellMargin;
    CGFloat nameX = margin;
    CGFloat nameY = margin;
    
    NSString *name = [NSString stringWithFormat:@"@%@", status.user.name];
    CGSize nameSize = [name sizeWithAttributes:@{NSFontAttributeName: XYStatusCellNameFont}];
    _retweetedNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //text
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetedNameFrame) + margin;
    CGSize textSize = [self textSizeWithText:status.text];
    _retweetedTextFrame = (CGRect){{textX, textY}, textSize};
    
    //
    CGFloat retweetedH = CGRectGetMaxY(_retweetedTextFrame) + margin;
    
    //photos
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(_retweetedTextFrame) + margin;
        CGSize photosSize = [self photoSizeWithCount:status.pic_urls.count];
        _retweetedPhotosFrame = (CGRect){{photosX, photosY}, photosSize};
        
        retweetedH = CGRectGetMaxY(_retweetedPhotosFrame) + margin;
    }
    
    _retweetedViewFrame = CGRectMake(0, CGRectGetMaxY(_originalViewFrame), XYScreenWidth, retweetedH);
}


//计算图片占的size
- (CGSize)photoSizeWithCount:(NSInteger)count{
    NSInteger column = count == 4 ? 2 : 3;
    NSInteger row = (count - 1) / column + 1;
    
    CGFloat margin = XYStatusCellMargin;
    CGFloat wh = 70;
    CGFloat w = column * wh + margin * (column - 1);
    CGFloat h = row * wh + margin * (row - 1);
    return CGSizeMake(w, h);
}

//计算正文占的size
- (CGSize)textSizeWithText:(NSString *)text{
    return [text boundingRectWithSize:CGSizeMake(XYScreenWidth - XYStatusCellMargin * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:XYStatusCellTextFont} context:nil].size;
}
@end
