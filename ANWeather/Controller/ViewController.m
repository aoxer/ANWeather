//
//  ViewController.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ANWeatherData.h"
#import "ANDailyForecastM.h"
#import "ANWeatherView.h"
@interface ViewController ()


@property (strong, nonatomic)ANWeatherView *weatherView;
/**
 *  天气数据模型
 */
@property (strong, nonatomic)ANWeatherData *weatherData;


@end

@implementation ViewController



- (void)viewDidLoad {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self sendRequest];
    
    // 添加天气View
    self.weatherView = [[ANWeatherView alloc] initWithFrame:self.view.bounds];
    [self.weatherView weatherView];
    [self.view addSubview:_weatherView];
}

- (void)sendRequest
{
    //http://apis.baidu.com/heweather/weather/free
    // appKey b8e9ab215ac9fd93a92939ab2718ab60
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    // 请求头文件
    [mgr.requestSerializer setValue:@"b8e9ab215ac9fd93a92939ab2718ab60" forHTTPHeaderField:@"apikey"];
    
    NSString *requsetURL = @"http://apis.baidu.com/heweather/weather/free";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"beijing" forKey:@"city"];
    
    [mgr GET:requsetURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *WeatherDict = [responseObject[@"HeWeather data service 3.0"] lastObject];
        
//        NSArray *dailayForecastArray = WeatherDict[@"daily_forecast"];
//        NSMutableDictionary *aqiDict = WeatherDict[@"aqi"][@"city"];
//        NSMutableDictionary *nowDict = WeatherDict[@"now"];

        ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:WeatherDict];
        self.weatherView.weatherData = weatherData;
        ANLog(@"%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"%@",error);
    }];
    
}







@end
