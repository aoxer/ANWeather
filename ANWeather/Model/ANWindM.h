//
//  ANWindM.h
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  
 
 "deg": "10", //风向（360度）
 "dir": "北风", //风向
 "sc": "3级", //风力
 "spd": "15" //风速（kmph）

 */
@interface ANWindM : NSObject
/**
 *  风向
 */
@property (copy, nonatomic)NSString *dir;
/**
 *  风力几级
 */
@property (copy, nonatomic)NSString *sc; 
@end
