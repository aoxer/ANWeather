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


#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>


@property (strong, nonatomic)ANWeatherView *weatherView;
/**
 *  天气数据模型
 */
@property (strong, nonatomic)ANWeatherData *weatherData;

/**
 *  位置管理者
 */
@property (strong, nonatomic)CLLocationManager *locationMgr;
@property (strong, nonatomic)CLGeocoder *geocoder;

/**
 *  获取当前城市
 */
@property (copy, nonatomic)NSString *city;

@end

@implementation ViewController

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (CLLocationManager *)locationMgr
{
    if (!_locationMgr) {
        _locationMgr = [[CLLocationManager alloc] init];
    }
    return _locationMgr;
}

- (void)viewDidLoad {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"right" style:UIBarButtonItemStyleDone target:self action:@selector(getLocation)];
    
    [self sendRequestWithCity:@"beijing"];
    
    // 添加天气View
    self.weatherView = [[ANWeatherView alloc] initWithFrame:self.view.bounds];
    [self.weatherView weatherView];
    [self.view addSubview:_weatherView];
    

    // 成为CoreLocation管理者的代理监听获取到的位置
    self.locationMgr.delegate = self;
  
    // 如果是iOS8+ 请求位置授权
    if (IOS_8_ABOVE) {
        [self.locationMgr requestAlwaysAuthorization];
    } else {
        [self.locationMgr startUpdatingLocation];
    }
    
}

- (void)getLocation
{
    // (开始获取位置)
    [self.locationMgr startUpdatingLocation];
}

// 发送数据请求
- (void)sendRequestWithCity:(NSString *)city
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
    [param setValue:city forKey:@"city"];
    
    [mgr GET:requsetURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableDictionary *WeatherDict = [responseObject[@"HeWeather data service 3.0"] lastObject];
        
//        NSArray *dailayForecastArray = WeatherDict[@"daily_forecast"];
//        NSMutableDictionary *aqiDict = WeatherDict[@"aqi"][@"city"];
//        NSMutableDictionary *nowDict = WeatherDict[@"now"];

        ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:WeatherDict];
        self.weatherView.weatherData = weatherData;
//        ANLog(@"%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"%@",error);
    }];
    
    
}


#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self.locationMgr stopUpdatingLocation];
    CLLocation *location = [locations lastObject];

    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *pm = [placemarks lastObject];
#warning 增加MBP
        // 把市去掉
        if ([pm.locality hasSuffix:@"市"]) {
            NSString *city = [pm.locality substringWithRange:NSMakeRange(0, pm.locality.length - 1)];
            
            [self sendRequestWithCity:city];
            
            ANLog(@"%@", city);
        }
        
    }];
}



@end
