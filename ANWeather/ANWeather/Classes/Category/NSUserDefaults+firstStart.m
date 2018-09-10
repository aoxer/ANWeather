//
//  NSUserDefaults+firstStart.m
//  ANWeather
//
//  Created by a on 16/1/13.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "NSUserDefaults+firstStart.h"

@implementation NSUserDefaults (firstStart)

+ (BOOL)isFirst
{
    // 第一次打开设置默认城市
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
       
        return YES;
    } else {
 
        return NO;
    }
    
    return YES;
}

@end
