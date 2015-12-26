//
//  ANTemM.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 "max": "34℃", //最高温度
 "min": "18℃" //最低温度
 */
@interface ANTemM : NSObject
/**
 *  最高温度
 */
@property (copy, nonatomic)NSString *max;
/**
 *  最低温度
 */
@property (copy, nonatomic)NSString *min;

@end
