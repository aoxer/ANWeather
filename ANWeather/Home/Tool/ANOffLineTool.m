//
//  ANOffLineTool.m
//  大安微博
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANOffLineTool.h"
#import "FMDB.h"
#import "ANBasicM.h"
#import "ANDailyForecastM.h"
#import "ANWeatherData.h"

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

 + (void)saveWeathersDictWithJson:(NSDictionary *)weathersDict
{
    // 要将一个对象存进数据库的blob字段, 最好先转为NSData
    // 一个对象要遵守NSCoding协议, 实现协议中的相应方法, 才能转成NSData
 
    NSData *weathersData = [NSKeyedArchiver archivedDataWithRootObject:weathersDict];
    // 拿到
    ANBasicM *basic = [ANBasicM objectWithKeyValues:weathersDict[@"basic"]]; 
    
    if ([self cityExists:basic.city]) { // 如果有当前城市缓存就更新
        
        [_db executeUpdate: @"UPDATE t_weathers SET weathers = ? WHERE city = ?", weathersData, basic.city];
    } else { // 没有就创建
        [_db executeUpdateWithFormat:@"INSERT INTO t_weathers (weathers, city) VALUES (%@, %@)", weathersData, basic.city];
    }

    
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

+ (NSString *)getLastCity
{
    NSString *sql = @"SELECT city FROM t_weathers";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    NSString *city = [NSString string];
    while (set.next) {

        city = [set objectForColumnName:@"city"];

    }
    
    return city;
}


#warning 判断是否为今天 待做

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
   NSDictionary *weatherDict = [self weathersWithCity:city];
    
    ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:weatherDict];
    
    NSString *date = weatherData.basic.update.loc;
    
    NSString *dateWithoutTime = [date substringWithRange:NSMakeRange(0, 10)];
    
    if ([dateWithoutTime isToday]) {
        return YES;
    }
    return NO;
}


@end






















