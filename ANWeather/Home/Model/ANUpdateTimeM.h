//
//  ANUpdateTimeM.h
//  ANWeather
//
//  Created by a on 16/1/12.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANUpdateTimeM : NSObject
/*
 update = {
    loc = 2016-01-10 00:18,
    utc = 2016-01-09 16:18
 }
 */

/**
 *  本地时间 loc = 2016-01-10 00:18,
 */
@property (copy, nonatomic)NSString *loc;
@end
