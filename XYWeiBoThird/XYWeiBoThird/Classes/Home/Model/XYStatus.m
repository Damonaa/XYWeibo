//
//  XYStatus.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/26.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYStatus.h"
#import "MJExtension.h"
#import "XYPhoto.h"
#import "NSDate+MJ.h"

@implementation XYStatus

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls":[XYPhoto class]};
}

- (NSString *)created_at{
    
    //    NSLog(@"created_at %@", _created_at);
    
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dateForm.locale = [NSLocale localeWithLocaleIdentifier:@"zn_US"];
    NSDate *date = [dateForm dateFromString:_created_at];
    
    if ([date isThisYear]) {//今年
        if ([date isToday]) {//今天
            NSDateComponents *comp = [date deltaWithNow];
            //            NSLog(@"%ld  %ld, %ld", comp.hour, comp.minute, comp.second);
            if (comp.hour >= 1) {//大于一小时
                return [NSString stringWithFormat:@"%ld小时之前", comp.hour];
            }else if (comp.minute > 1){//一分钟到一小时之间
                return [NSString stringWithFormat:@"%ld分钟之前", comp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([date isYesterday]){//昨天
            dateForm.dateFormat = @"昨天: HH:mm";
            return [dateForm stringFromDate:date];
        }else{//前天之前
            dateForm.dateFormat = @"MM-dd HH:mm";
            return [dateForm stringFromDate:date];
        }
        
        
    }else{//去年
        dateForm.dateFormat = @"yyyy-MM-dd HH:mm";
        return [dateForm stringFromDate:date];
    }
    
    return _created_at;
}

//getter 方法，读取
- (NSString *)source{
    NSString *new = _source;
    if (_source.length > 0) {
        
        NSRange range = [new rangeOfString:@">"];
        
        new = [new substringFromIndex:range.length + range.location];
        
        range = [new rangeOfString:@"<"];
        
        new = [new substringToIndex:range.location];
    }
    

    return new;
}

@end
