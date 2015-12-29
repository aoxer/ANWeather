//
//  ANCondM.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANCondM : NSObject
/**
 *   "txt": "晴" //天气状况描述
 */
@property (copy, nonatomic)NSString *txt;
/**
 *   "txt": "晴" //白天天气状况描述
 */
@property (copy, nonatomic)NSString *txt_d;
@end
