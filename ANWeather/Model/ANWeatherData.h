//
//  ANWeatherData.h
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANWeatherData : NSObject

/**
 *  "city": "北京",  //城市名称
 */
@property (copy, nonatomic)NSString *city;
/**
 *  "dir": "北风", //风向
 */
@property (copy, nonatomic)NSString *dir;
/**
 *  "sc": "3级", //风力
 */
@property (copy, nonatomic)NSString *sc;
/**
 *  "pm25": "7", //PM2.5 1小时平均值(ug/m³)
 */
@property (copy, nonatomic)NSString *pm25;

/**
 *"spd": "15" //风速（kmph）
 */
@property (copy, nonatomic)NSString *spd;

@property (strong, nonatomic)NSMutableArray *ditailArray;



@end
