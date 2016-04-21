//
//  XYStatus.m
//  Weibo
//
//  Created by 李小亚 on 16/3/20.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatus.h"
#import "XYPhoto.h"
#import "NSDate+MJ.h"
#import "XYUser.h"

@implementation XYStatus

/**
 *  将数组中的元素转换为模型
 */
- (NSDictionary *)objectClassInArray{
    return @{@"pic_urls": [XYPhoto class]};
}

- (NSString *)created_at{
//    NSLog(@"created_at %@", _created_at);
    
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    dateFormate.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dateFormate.locale = [NSLocale localeWithLocaleIdentifier:@"zn_US"];
    
    NSDate *date = [dateFormate dateFromString:_created_at];
    
    if ([date isThisYear]) {//今年
        if ([date isToday]) {//今天
            NSDateComponents *comp = [date deltaWithNow];
            
            if (comp.hour >= 1) {//大于1小时
                return [NSString stringWithFormat:@"%ld小时前",comp.hour];
            }else if (comp.minute > 1){//大于1分钟
                return [NSString stringWithFormat:@"%ld分钟前", comp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([date isYesterday]){//昨天
            dateFormate.dateFormat = @"昨天: HH:mm:ss";
            return [dateFormate stringFromDate:date];
        }else{//前天及以前
            dateFormate.dateFormat = @"MM-dd HH:mm:ss";
            return [dateFormate stringFromDate:date];
        }
    }else{//去年以及以前
        dateFormate.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [dateFormate stringFromDate:date];
    }
    
    return _created_at;
}

//getter 方法，读取
- (NSString *)source{
//    NSLog(@"%@", _source);
    //判断是否有来源
    if (_source.length != 0) {
        NSString *new = _source;
        NSRange range = [new rangeOfString:@">"];
        
        new = [new substringFromIndex:range.length + range.location];
        
        range = [new rangeOfString:@"<"];
        
        new = [new substringToIndex:range.location];
        
        return new;
    }
    return _source;
}

//重新设置转发微博的作者昵称
- (void)setRetweeted_status:(XYStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    
    NSString *newName = retweeted_status.user.name;
    newName = [NSString stringWithFormat:@"@%@", newName];
    _retweeted_status.user.name = newName;
}
@end
