//
//  ArkReqTool.h
//  ANWeather
//
//  Created by 小华 on 2018/9/11.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArknowM;
@interface ArkReqTool : NSObject

+ (void)reqWeatherData:(NSString *)city
               success:(void (^)(ArknowM *nowm))success
               failure:(void (^)(void))failure;
@end
