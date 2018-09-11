//
//  ArkReqTool.m
//  ANWeather
//
//  Created by 小华 on 2018/9/11.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

#import "ArkReqTool.h"
#import "ArknowM.h"

@implementation ArkReqTool

+ (void)reqWeatherData:(NSString *)city
               success:(void (^)(ArknowM *nowm))success
               failure:(void (^)(void))failure

{
    __block NSMutableArray *datas=[NSMutableArray array];
    
    dispatch_group_t weatherData = dispatch_group_create();

    dispatch_group_enter(weatherData);

    dispatch_group_async(weatherData, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求1
        [self afnMethodWithURL:ANWeatherRequestUrlnow city:city datas:datas weatherData:weatherData];
    });
    
    dispatch_group_enter(weatherData);

    dispatch_group_async(weatherData, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求2
        [self afnMethodWithURL:ANWeatherRequestUrlparameters city:city datas:datas weatherData:weatherData];

    });
    
    dispatch_group_enter(weatherData);

    dispatch_group_async(weatherData, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //请求3
        [self afnMethodWithURL:ANWeatherRequestUrlforecast city:city datas:datas weatherData:weatherData];
    });

    dispatch_group_notify(weatherData, dispatch_get_main_queue(), ^{

        if (datas.count<3) {
            failure();
        }else{
            NSMutableDictionary *mdict=[NSMutableDictionary dictionary];
            
            if ([self dataAnalysis:datas response:mdict]) {
                success([ArknowM objectWithKeyValues:mdict]);
            }else{
                failure();
            }
        }
        
    });
    
}

+ (void)afnMethodWithURL:(NSString *)URL
                    city:(NSString *)city
                   datas:(NSMutableArray *)datas
             weatherData:(dispatch_group_t)weatherData
{
    [AFNTool reqGetWithURl:URL parameters:[RequestDataModel reqParamLoction:city] success:^(id responseObject) {
        [datas addObject:responseObject];
        dispatch_group_leave(weatherData);
    }failure:^(NSError *error) {
        dispatch_group_leave(weatherData);
    }];
}

+ (BOOL )dataAnalysis:(NSArray *)datas response:(NSMutableDictionary *)mdict
{
    BOOL Analysis=YES;
    
    NSMutableDictionary *weathersDict1 = datas.firstObject;
    NSMutableDictionary *weathersDict2 = datas[2];
    NSMutableDictionary *weathersDict3 = datas.lastObject;
    
    BOOL statu1 =[[weathersDict1[@"HeWeather6"] firstObject][@"status"] isEqualToString:@"ok"];
    BOOL statu2 =[[weathersDict2[@"HeWeather6"] firstObject][@"status"] isEqualToString:@"ok"];
    BOOL statu3 =[[weathersDict3[@"HeWeather6"] firstObject][@"status"] isEqualToString:@"ok"];

    if (statu1&&statu2&&statu3) {
        
        for (NSDictionary *dict in datas) {
            NSDictionary *dataDict=[dict[@"HeWeather6"] firstObject];
            if([[dataDict allKeys] containsObject:@"air_now_city"]){
                [mdict addEntriesFromDictionary:dataDict[@"air_now_city"]];
                [mdict setValue:dataDict[@"air_now_station"] forKey:@"air_now_station"];
            }else if ([[dataDict allKeys] containsObject:@"now"]){
                [mdict addEntriesFromDictionary:dataDict[@"now"]];
            }else{
                [mdict addEntriesFromDictionary:[dataDict[@"daily_forecast"] firstObject]];
                [mdict setValue:dataDict[@"daily_forecast"] forKey:@"daily_forecast"];
            }
        }
        
    }else{
        Analysis=NO;
    }
    
    return Analysis;
}

@end
