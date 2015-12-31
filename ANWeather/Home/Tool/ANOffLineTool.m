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
@implementation ANOffLineTool

static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weaters.sqlite"];
    ANLog(@"%@", path);
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:
     @"CREATE TABLE IF NOT EXISTS t_weathers(id integer PRIMARY KEY, weathers blob NOT NULL, city blob NOT NULL)"];
}

+ (void)saveWeathersDictWithJson:(NSDictionary *)weathersDict
{
    // 要将一个对象存进数据库的blob字段, 最好先转为NSData
    // 一个对象要遵守NSCoding协议, 实现协议中的相应方法, 才能转成NSData
 
    NSData *weathersData = [NSKeyedArchiver archivedDataWithRootObject:weathersDict];
    // 把city转成NSData
    ANBasicM *basic = [ANBasicM objectWithKeyValues:weathersDict[@"basic"]];
    NSData *cityData = [NSKeyedArchiver archivedDataWithRootObject:basic.city];
    
    [_db executeUpdateWithFormat:@"INSERT INTO t_weathers (weathers, city) VALUES (%@, %@)", weathersData, cityData];
}

+ (NSDictionary *)weathersWithCity:(NSString *)city
{
    NSString *sql = @"SELECT * FROM t_weathers";
    
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
   
    
    NSString *sql = @"SELECT * FROM t_weathers";
    
    FMResultSet *set = [_db executeQuery:sql];
    
    NSMutableString *city = [NSMutableString string];
    while (set.next) {
        NSData *cityData = [set objectForColumnName:@"city"];
        city = [NSKeyedUnarchiver unarchiveObjectWithData:cityData];
    }
    ANLog(@"ANOffLintTool city--%@", city);
    return city;
}
@end






















