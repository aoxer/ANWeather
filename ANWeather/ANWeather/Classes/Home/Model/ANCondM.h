//
//  ANCondM.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANCondM : NSObject

/*
 now
 "cond": { //天气状况
     "code": "100", //天气状况代码
     "txt": "晴" //天气状况描述
 },
 daily_forcast
 "cond": { //天气状况
     "code_d": "100", //白天天气状况代码，参考http://www.heweather.com/documents/condition-code
     "code_n": "100", //夜间天气状况代码
     "txt_d": "晴", //白天天气状况描述
     "txt_n": "晴" //夜间天气状况描述
 },
 */

/**
 *   "txt": "晴" //当前天气状况描述
 */
@property (copy, nonatomic)NSString *txt;
/**
 *  "code": "100", //当前天气状况代码
 */
@property (copy, nonatomic)NSString *code;
/**
 *  "code_d": "100", //白天天气状况代码
 */
@property (copy, nonatomic)NSString *code_d;
/**
 *  "txt_d": "晴", //白天天气状况描述
 */
@property (copy, nonatomic)NSString *txt_d;

@end
