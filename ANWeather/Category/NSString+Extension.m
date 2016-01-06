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
@end
