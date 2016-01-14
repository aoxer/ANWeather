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
 *  判断是否有当前城市缓存
 */
+ (BOOL)cityExists:(NSString *)city;
 /**
 *  判断当前城市数据是否为今天
 */
+ (BOOL)CityWeatherIsToday:(NSString *)city;
 
 @end
