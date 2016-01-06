//
//  NSString+Extension.h
//  ANWeather
//
//  Created by a on 16/1/5.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  把"市"字去掉
 */
- (NSString *)removeShi;
/**
 *  有市字就把市去掉 是州则取下级城市
 *
 *  @param subLocality 下级城市
 */
- (NSString *)getCityName:(NSString *)subLocality;
@end
