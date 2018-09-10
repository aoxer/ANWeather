//
//  ANOffLineTool.m
//  大安微博
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANOffLineTool.h"
#import "FMDB.h"

@interface ANOffLineTool ()


@end

@implementation ANOffLineTool

static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weaters.sqlite"];
    ANLog(@"%@", path);
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:
     @"CREATE TABLE IF NOT EXISTS t_weathers(id integer PRIMARY KEY, weathers blob NOT NULL, city text NOT NULL)"];
    
    
}

//szh
 + (void)saveWeathersDictWithJson:(NSDictionary *)weathersDict
{
    // 要将一个对象存进数据库的blob字段, 最好先转为NSData
    // 一个对象要遵守NSCoding协议, 实现协议中的相应方法, 才能转成NSData
 
    NSData *weathersData = [NSKeyedArchiver archivedDataWithRootObject:weathersDict];
    // 拿到
//    ANBasicM *basic = [ANBasicM objectWithKeyValues:weathersDict[@"basic"]]; 
//    
//    if ([self cityExists:basic.city]) { // 如果有当前城市缓存就更新
//        
//        [_db executeUpdate: @"UPDATE t_weathers SET weathers = ? WHERE city = ?", weathersData, basic.city];
//    } else { // 没有就创建
//        [_db executeUpdateWithFormat:@"INSERT INTO t_weathers (weathers, city) VALUES (%@, %@)", weathersData, basic.city];
//    }
//    
//    // 保存当前城市到本地
//    [self saveLastCity:basic.city];

    
}

+ (NSDictionary *)weathersWithCity:(NSString *)city
{
        // 获取传进来城市的天气
    NSString *sql = [NSString stringWithFormat:@"SELECT weathers FROM t_weathers WHERE city = '%@'", city];
    
    FMResultSet *set = [_db executeQuery:sql];
    
    NSMutableDictionary *weathersDict = [NSMutableDictionary dictionary];
    while (set.next) {
        NSData *weathersData = [set objectForColumnName:@"weathers"];
        weathersDict = [NSKeyedUnarchiver unarchiveObjectWithData:weathersData];
    }
    
    return weathersDict;
}

+ (BOOL)cityExists:(NSString *)city
{
    NSString *sql = @"SELECT city FROM t_weathers";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    NSString *cityName = nil;
    while (set.next) {
        
        cityName = [set stringForColumn:@"city"];
        // 如果返回的结果里有传进来的城市数据
        if ([cityName isEqualToString:city]) {
            return YES;
        }
    }
    
    return NO;
}

 
+ (BOOL)CityWeatherIsToday:(NSString *)city
{
   NSDictionary *weatherDict = [self weathersWithCity:city];//szh
//
//    ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:weatherDict];
//
//    NSString *date = weatherData.loc;
//
//    NSString *dateWithoutTime = [date substringWithRange:NSMakeRange(0, 10)];
//
//    if ([dateWithoutTime isToday]) {
//        return YES;
//    }
    return NO;
}

+ (NSString *)getLastCity
{
    NSString *lastCityPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.last"];
    
    NSString *city = [NSKeyedUnarchiver unarchiveObjectWithFile:lastCityPath];
    return city;
}

// 保存上次打开的城市
+ (void)saveLastCity:(NSString *)city
{
    NSString *lastCityPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.last"];
    [NSKeyedArchiver archiveRootObject:city toFile:lastCityPath];
}

// 保存当前城市
+ (void)saveCurrentCity:(NSString *)city
{
    NSString *currentCity = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.current"];
    [NSKeyedArchiver archiveRootObject:city toFile:currentCity];
    
}

// 拿到当前城市
+ (NSString *)getCurrentCity
{
    NSString *lastCityPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.current"];
    
    NSString *city = [NSKeyedUnarchiver unarchiveObjectWithFile:lastCityPath];
    return city;
}


@end






















