//
//  ANAreaM.m
//  ANWeather
//
//  Created by a on 16/1/6.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANAreaM.h"
#import "ANCityM.h"

@implementation ANAreaM

- (NSDictionary *)objectClassInArray
{
    return @{ @"city" : [ANCityM class]};
}
@end
