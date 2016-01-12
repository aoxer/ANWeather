//
//  ANBasicM.h
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANUpdateTimeM.h"
/*
basic = {
 cnty = 中国,
 id = CN101010100,
 lat = 39.904000,
 city = 北京,
 lon = 116.391000,
 update = {
 loc = 2015-12-25 20:04,
 utc = 2015-12-25 12:04
 }
 }
 */
@interface ANBasicM : NSObject
/**
 *  city = 北京,
 */
@property (copy, nonatomic)NSString *city;
/**
 *  更新时间的模型
 */
@property (strong, nonatomic)ANUpdateTimeM *update;
@end
