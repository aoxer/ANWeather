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
 *  风力
 */
+ (BOOL)isLevel;
/**
 *  大手
 */
+ (BOOL)isBigHand;
/**
 *  摇否
 */
+ (BOOL)isShakeEnable;

@end
