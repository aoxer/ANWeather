//
//  ANDailyForecastM.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANWindM.h"
#import "ANTemM.h"
#import "ANCondM.h"
/*
 "date": "2015-07-02", //预报日期
 */
@interface ANDailyForecastM : NSObject
/**
 *  最高温最低温的模型
 */
@property (strong, nonatomic)ANTemM *tmp;
/**
 *  风的模型
 */
@property (strong, nonatomic)ANWindM *wind;
/**
 *  预报日期
 */
@property (copy, nonatomic)NSString *date;
/**
 *  天气描述
 */
@property (strong, nonatomic)ANCondM *cond;
@end
