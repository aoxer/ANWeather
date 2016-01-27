//
//  NSString+Extension.m
//  ANWeather
//
//  Created by a on 16/1/5.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString *)getCityName:(NSString *)subLocality
{
    NSString *cityNameWithoutShi = nil;
    if ([self hasSuffix:@"市"]) { // 有市就把市去掉
        cityNameWithoutShi = [self substringWithRange:NSMakeRange(0, self.length - 1)];
        
    } else if ([self hasSuffix:@"州"]) { // 如果是州 (大理白族自治州) 则获取下级城市
        cityNameWithoutShi = [subLocality removeShi];
    }
    
    return cityNameWithoutShi;
}

- (NSString *)removeShi
{
    NSString *cityNameWithoutShi = nil;
    if ([self hasSuffix:@"市"]) { // 有市就把市去掉
        cityNameWithoutShi = [self substringWithRange:NSMakeRange(0, self.length - 1)];
        
    } else {
        cityNameWithoutShi = self;
    }
    
    return cityNameWithoutShi;
}

- (BOOL)isToday
{
    
    NSDate *date = [NSDate date];
    // 获取市区并加上相差时间
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:date];
//    NSDate *locDate = [date dateByAddingTimeInterval:interval];
//    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *timeStr = [fmt stringFromDate:date];
    
//    NSString *dateWithoutTime = [timeStr substringWithRange:NSMakeRange(0, 10)];
    
    if ([self isEqualToString:timeStr]) {
        return YES;
    }
    
    return NO;
   
}


/**
 *  转为attrStr
 */
+ (NSAttributedString *)attrStringWithStr:(NSString *)string
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attr addAttribute:NSForegroundColorAttributeName value:ANColor(155, 158, 169, 1) range:NSMakeRange(0, string.length)];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, string.length)];

    return attr;
}

@end
