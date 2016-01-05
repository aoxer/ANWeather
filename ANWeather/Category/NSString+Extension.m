//
//  NSString+Extension.m
//  ANWeather
//
//  Created by a on 16/1/5.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (NSString *)removeShi
{
    NSString *cityNameWithoutShi = nil;
    if ([self hasSuffix:@"市"]) {
        cityNameWithoutShi = [self substringWithRange:NSMakeRange(0, self.length - 1)];
        
    } else {
        cityNameWithoutShi = self;
    }
    
    return cityNameWithoutShi;
}
@end
