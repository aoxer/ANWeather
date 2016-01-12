//
//  ANOffLineTool.h
//  大安微博
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANOffLineTool : NSObject
/**
 *  把返回的json存到本地
 */
+ (void)saveWeathersDictWithJson:(NSDictionary *)weathersDict;
/**
 * 根据城市名去沙盒中加载缓存
 */
+ (NSDictionary *)weathersWithCity:(NSString *)city;

/**
 *  获取上一次的城市
 */
+ (NSString *)getLastCity;

/**
 *  判断缓存文件是否存在
 */
+ (BOOL)cityExists:(NSString *)city;
/**
 *  是否为第一次打开
 */
+ (BOOL)isFirst;
/**
 *  判断当前城市是否为今天
 */
+ (BOOL)CityWeatherIsToday:(NSString *)city;

@end
