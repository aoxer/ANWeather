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
#import "MBProgressHUD+MJ.h"
#import "RESideMenu.h"
#import "ANDaysWeatherCell.h"
#import "MJRefresh.h"


#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic)ANWeatherView *weatherView;
/**
 *  天气数据模型
 */
@property (strong, nonatomic)ANWeatherData *weatherData;
/**
 *  几日天气模型数组
 */
@property (strong, nonatomic)NSMutableArray *dailyForecastArray;


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

#pragma mark 懒加载们
- (NSMutableArray *)dailyForecastArray
{
    if (!_dailyForecastArray) {
        _dailyForecastArray = [NSMutableArray array];
    }
    return _dailyForecastArray;
}

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
    
    self.locationMgr.distanceFilter = 1000.f;
    
    // 设置tableView
    [self setupTableView];
    
    // 设置导航栏
    [self setupNavigaitonItem];
    
    // 发送请求
    [self sendRequestWithCity:@"shanghai"];
    
    // 添加天气View
    [self SetupWeatherView];
    
    // 成为CoreLocation管理者的代理监听获取到的位置
    self.locationMgr.delegate = self;
  
    // 如果是iOS8+ 请求位置授权
    [self requestAuthorizaiton];
    
}

/**
 *  初始化tableView
 */
- (void)setupTableView
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
#warning 刷新没做
        
        [self.tableView.header endRefreshing];
    }];
    
}

- (void)pullDownRefreshingWithCity:(NSString *)city
{
   
}


/**
 *  如果是iOS8+ 请求位置授权
 */
- (void)requestAuthorizaiton
{
    if (IOS_8_ABOVE) {
        [self.locationMgr requestAlwaysAuthorization];
    } else {
        [self.locationMgr startUpdatingLocation];
    }
    
}

/**
 *  设置导航栏
 */
- (void)setupNavigaitonItem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callLeft) andImageName:@"top_navigation_menuicon" andImageNameHighlight:nil];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(getLocation) andImageName:@"location" andImageNameHighlight:nil];
    self.navigationController.navigationBar.barTintColor = ANColor(40, 40, 40, 0.3);


}

- (void)callLeft
{
    [self.sideMenuViewController presentLeftMenuViewController];
    
}
/**
 *  设置天气控件
 */
- (void)SetupWeatherView
{
    self.weatherView = [[ANWeatherView alloc] initWithFrame:self.view.bounds];
    self.weatherView.showsVerticalScrollIndicator = NO;
    self.weatherView.backgroundColor = ANColor(40, 40, 40, 1);
    self.weatherView.delegate = self;
    self.weatherView.dataSource = self;
    
    [self.weatherView weatherView];
    [self.view addSubview:_weatherView];
}

/**
 *  获取位置
 */
- (void)getLocation
{
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] !=kCLAuthorizationStatusDenied) {
        // 弹出提示HUD
        [MBProgressHUD showMessage:@"定位ing..."];
        // (开始获取位置)
        [self.locationMgr startUpdatingLocation];
    } else {
        // 弹出提醒 并作点击ok跳转
        [self showAlertForLoaction];
    }
}


/**
 *  弹出提醒设置定位功能
 */
-(void)showAlertForLoaction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"定位功能未开启" message:@"是否打开？" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction  *cancel = [UIAlertAction actionWithTitle:@"不打" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        ANLog(@"cancelClickd");
    }];

    UIAlertAction  *ok = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
            [[UIApplication sharedApplication] openURL:url];
        }

    }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    

}
/**
 *  发送数据请求
 */
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
        
#warning 转为模型数组
        self.dailyForecastArray = [ANDailyForecastM objectArrayWithKeyValuesArray:WeatherDict[@"daily_forecast"]];
        
//        NSMutableDictionary *aqiDict = WeatherDict[@"aqi"][@"city"];
//        NSMutableDictionary *nowDict = WeatherDict[@"now"];

        ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:WeatherDict];
        self.weatherView.weatherData = weatherData;
        
//        ANLog(@"%@", responseObject);
        [self.weatherView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"%@",error);
    }];
    
    
}




#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:@"定位失败啥的"];
}

/**
 *  位置发生改变时调用
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    
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
        
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        if (error) {
            // 隐藏HUD
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"定位失败请fdsafd"];
        }
    }];
    
//    [self.locationMgr stopUpdatingLocation];

}

- (void)dealloc
{
    [ANNotificationCenter removeObserver:self];
}
#pragma mark  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    
    return self.dailyForecastArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANDaysWeatherCell *cell = [ANDaysWeatherCell cellWithTableView:tableView];

    cell.dailyForcast = self.dailyForecastArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


//#pragma mark ANDaysWeatherCellDelegate
//- (void)daysWeatherCell:(ANDaysWeatherCell *)didChangeData
//{
//    [self.weatherView reloadData];
//}

@end
