//
//  ANWeatherData.m
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANWeatherData.h" 

@implementation ANWeatherData
- (NSDictionary *)objectClassInArray
{
    return @{ @"daily_forecast" : [ANDailyForecastM class]};
}



    


@end
