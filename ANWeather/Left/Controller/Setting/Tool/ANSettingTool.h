//
//  ANSettingTool.h
//  ANWeather
//
//  Created by a on 16/1/13.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANSettingTool : NSObject
/**
 *  摄氏度
 */
+ (BOOL)isC;
/**
 *  风力等级
 */
+ (BOOL)isWindScale;
/**
 *  大手
 */
+ (BOOL)isBigHand;
/**
 *  摇否
 */
+ (BOOL)isShakeEnable;
/**
 *  第一次打开的话设置数据
 */
+ (void)setup;

/**
 * 更新温度模式
 */
+ (void)updateC:(int)value;
/**
 *  更新风速模式
 */
+ (void)updateWindScale:(int)value;
/**
 *  更新大小手模式
 */
+ (void)updateBigHand:(int)value;
/**
 *  更新摇一摇状态
 */
+ (void)updateShakeEnable:(int)value;
@end
