//
//  ANAreaM.h
//  ANWeather
//
//  Created by a on 16/1/6.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ANAreaM : NSObject
/**
 *  省
 */
@property (copy, nonatomic)NSString *area;
/**
 *  市
 */
@property (strong, nonatomic)NSMutableArray *city;
@end
