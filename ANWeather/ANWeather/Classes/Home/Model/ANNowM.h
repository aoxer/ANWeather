//
//  ANNowM.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANWindM.h"
#import "ANCondM.h"
@interface ANNowM : NSObject
/**
 "fl": "30", //体感温度
 "hum": "20%", //相对湿度（%）
 "pcpn": "0.0", //降水量（mm）
 "pres": "1001", //气压
 "tmp": "32", //温度
 "vis": "10", //能见度（km）
 "wind": { //风力风向
 "deg": "10", //风向（360度）
 "dir": "北风", //风向
 "sc": "3级", //风力
 "spd": "15" //风速（kmph）
 }
 */

/**
 *  当前温度
 */
@property (copy, nonatomic)NSString *tmp;
/**
 *  相对湿度
 */
@property (copy, nonatomic)NSString *hum;
/**
 *  风的模型
 */
@property (strong, nonatomic)ANWindM *wind;
/**
 * 天气状况
 */
@property (strong, nonatomic)ANCondM *cond;

@end
