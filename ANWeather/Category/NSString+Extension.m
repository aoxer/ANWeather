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
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *compoent = [calender components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    // 把2016-1-9改为2016-01-09;
    NSString *month = nil;
    NSString *day = nil;
    if ([NSString stringWithFormat:@"%zd", compoent.month].length == 1 ||
        [NSString stringWithFormat:@"%zd", compoent.day].length == 1) {
        
        month = [NSString stringWithFormat:@"0%zd", compoent.month];
        day = [NSString stringWithFormat:@"0%zd", compoent.day];
        
    }
    NSString *date = [NSString stringWithFormat:@"%zd-%@-%@", compoent.year, month, day];
    
    if ([self isEqualToString:date]) {
        return YES;
    }
    return NO;
}
@end
