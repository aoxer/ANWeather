//
//  ANCity.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "aqi": { //空气质量，仅限国内部分城市，国际城市无此字段
 "city": {
 "aqi": "30", //空气质量指数
 "co": "0", //一氧化碳1小时平均值(ug/m³)
 "no2": "10", //二氧化氮1小时平均值(ug/m³)
 "o3": "94", //臭氧1小时平均值(ug/m³)
 "pm10": "10", //PM10 1小时平均值(ug/m³)
 "pm25": "7", //PM2.5 1小时平均值(ug/m³)
 "qlty": "优", //空气质量类别
 "so2": "3" //二氧化硫1小时平均值(ug/m³)
 }
 },
 */
@interface ANCity : NSObject
/**
 *  空气质量类别
 */
@property (copy, nonatomic)NSString *qlty;
/**
 *  pm2.5
 */
@property (copy, nonatomic)NSString *pm25;
@end
