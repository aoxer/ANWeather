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
    if (![kUserDefaults boolForKey:@"firstStart"]){
        [kUserDefaults setBool:YES forKey:@"firstStart"];
        return YES;
    }else{
        return NO;
    }
    
}

@end
