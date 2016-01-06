//
//  ANWeatherData.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANNowM.h"
#import "ANDailyForecastM.h"
#import "ANAqiM.h"
#import "ANBasicM.h"
#import "ANStatusM.h"

//@class ANNowM, ANDailyForecastM, ANAqiM, ANBasicM, ANStatusM;

@interface ANWeatherData : NSObject
/**
 *  当前天气的模型
 */
@property (strong, nonatomic)ANNowM *now;
/**
 *  空气质量的模型
 */
@property (strong, nonatomic)ANAqiM *aqi;
/**
 *  几日天气的模型数组
 */
@property (strong, nonatomic)NSMutableArray *daily_forecast;
/**
 *  城市基本信息
 */
@property (strong, nonatomic)ANBasicM *basic;
/**
 *  城市基本信息
 */
@property (strong, nonatomic)ANStatusM *status;


@end
