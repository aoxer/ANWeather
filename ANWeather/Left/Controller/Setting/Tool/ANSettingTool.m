//
//  ANSettingTool.m
//  ANWeather
//
//  Created by a on 16/1/13.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANSettingTool.h"
#import "FMDB.h"

NSString * const isC = @"isC";
NSString * const isWindScale = @"isWindScale";
NSString * const isBigHand = @"isBigHand";
NSString * const isShakeEnable = @"isShakeEnable";
NSString * const t_settings = @"t_settings";

@interface ANSettingTool ()
/**
 *  温度 C
 */
@property (assign, nonatomic)BOOL isC;
/**
 *  大手
 */
@property (assign, nonatomic)BOOL isBighand;
/**
 *  风力等级
 */
@property (assign, nonatomic)BOOL isWindScale;
/**
 *  摇否
 */
@property (assign, nonatomic)BOOL isShakeEnable;
@end

@implementation ANSettingTool

static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"settings.sqlite"];
    
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 创表
    NSString *sql = [NSString stringWithFormat: @"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY, %@ integer NOT NULL, %@ integer NOT NULL, %@ integer NOT NULL, %@ integer NOT NULL)", t_settings, isC, isBigHand, isWindScale, isShakeEnable];
    [_db executeUpdate:sql];
    
  
    
}


/**
 * 更新温度模式
 */
+ (void)updateC:(int)value
{
    if (![self isUseable]) { // 不能用就创建
        
        // 1为是 0为否
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_settings (%@,%@,%@,%@) VALUES (%d,%d,%d,%d)", isC, isWindScale, isBigHand, isShakeEnable, 1, 1, 1, 1];
        [_db executeUpdate: sql];
        
    } else { // 能用就更新
        
        NSString *sql = [NSString stringWithFormat:@"UPDATE t_settings SET %@ = %d", isC, value];
        [_db executeUpdate:sql];

    }
}

/**
 *  更新风速模式
 */
+ (void)updateWindScale:(int)value
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE t_settings SET %@ = %d", isWindScale, value];
    [_db executeUpdate:sql];
}

/**
 *  更新大小手模式
 */
+ (void)updateBigHand:(int)value
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE t_settings SET %@ = %d", isBigHand, value];
    [_db executeUpdate:sql];
}

/**
 *  更新摇一摇状态
 */
+ (void)updateShakeEnable:(int)value
{
    NSString *sql = [NSString stringWithFormat:@"UPDATE t_settings SET %@ = %d", isShakeEnable, value];
    [_db executeUpdate:sql];
}


/**
 *  摄氏度
 */
+ (BOOL)isC
{
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", isC, t_settings];
    FMResultSet *set = [_db executeQuery:sql];
    
    while (set.next) {
        
       return [set intForColumn:isC];
        
    }
    
    return NO;
}
/**
 *  风力等级
 */
+ (BOOL)isWindScale
{
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", isWindScale, t_settings];
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        
        return [set intForColumn:isWindScale];
    }
    
    return NO;
}
/**
 *  大手
 */
+ (BOOL)isBigHand
{
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", isBigHand, t_settings];
    FMResultSet *set = [_db executeQuery:sql];
    
    while (set.next) {
        
        return [set intForColumn:isBigHand];
    }
    
    return NO;
}
/**
 *  摇否
 */
+ (BOOL)isShakeEnable
{
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", isShakeEnable, t_settings];
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        
        return [set intForColumn:isShakeEnable];
    }
    
    return NO;
}

+ (BOOL)isUseable
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", t_settings];
    FMResultSet *set = [_db executeQuery:sql];
    
    while (set.next) {
        
        return YES;
    }
    
    return NO;

}
@end
