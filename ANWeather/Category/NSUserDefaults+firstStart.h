//
//  NSUserDefaults+firstStart.h
//  ANWeather
//
//  Created by a on 16/1/13.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (firstStart)
/**
 *  判断是否第一次打开
 */
+ (BOOL)isFirst;
@end
