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
#import "ANRightTableViewController.h"
#import "ANOffLineTool.h"



#import <CoreLocation/CoreLocation.h>


@interface ViewController ()<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

/**
 *  已选城市城市
 */
@property (copy, nonatomic)NSString *city;

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



@end

@implementation ViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置上一次城市
    [self setupLastCity];
    
    // 加载数据
    [self judgeCity];
    
    // 设置tableView
    [self setupTableView];
    
    // 设置导航栏
    [self setupNavigaitonItem];
    
    // 设置天气View
    [self SetupWeatherView];
    
    // 如果是iOS8+ 请求位置授权
    [self requestAuthorizaiton];
    
    // 成为CoreLocation管理者的代理监听获取到的位置
    self.locationMgr.delegate = self;
    // 更新位置为每1000m
    self.locationMgr.distanceFilter = 1000.f;
    
    // 监听定位的通知
    [ANNotificationCenter addObserver:self selector:@selector(getLocation) name:ANGetLocationDidClickNotification object:nil];
    
    // 监听缓存数据非今天的通知
//    [ANNotificationCenter addObserver:self selector:@selector(sendRequestWithCity:) name:@"isNotTodayNotification" object:nil];
    
    if (self.isComeLeft) {
        self.isComeLeft = NO;
    }
    
#warning 根据topView日期判断是否要刷新数据 通知
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self judgeCity];
  
    
}

#pragma mark 初始化方法
/**
 *  初始化tableView
 */
- (void)setupTableView
{
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = [UIColor lightGrayColor];
    // MJRefresh
    __weak typeof(self)weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 加载天气
        if (self.selectedCity.length != 0) { // 如果有已选城市 加载已选城市
            [weakSelf sendRequestWithCity:self.selectedCity];
        } else { // 没有则加载上次定位城市
            [weakSelf sendRequestWithCity:self.city];
        }
       
    }];
}

/**
 *  设置导航栏
 */
- (void)setupNavigaitonItem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callLeft) andImageName:@"navigationbar-sidebar" andImageNameHighlight:@"navigationbar-sidebar"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callRight) andImageName:@"add_element" andImageNameHighlight:@"add_element"];
    self.navigationController.navigationBar.barTintColor = ANColor(40, 40, 40, 0.3);
    // 设置导航栏文字颜色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:attr];
    
   
}

- (void)test
{

    [self.navigationController presentViewController:[[ANRightTableViewController alloc] init] animated:YES completion:nil];
}

/**
 *  设置天气控件
 */
- (void)SetupWeatherView
{
    self.weatherView.frame = self.view.bounds;
    
    self.weatherView.contentInset = UIEdgeInsetsMake(ANScreenHeight - 20 - self.navigationController.navigationBar.height, 0, 0, 0);
    
    self.weatherView.delegate = self;
    self.weatherView.dataSource = self;
     
    [self.weatherView weatherView];
    [self.view addSubview:_weatherView];
    
    ANLog(@"%@", self.weatherView);

}

/**
 *  如果是iOS8+ 请求位置授权
 */
- (void)requestAuthorizaiton
{
    if (IOS_8_ABOVE) {
        [self.locationMgr requestWhenInUseAuthorization];
    } else {
        [self.locationMgr startUpdatingLocation];
    }
    
}


#pragma mark 动作方法

- (void)setupLastCity
{
    
    if (![ANOffLineTool isFirst])
    {
        self.city = [ANOffLineTool getLastCity];
    } else {
#warning 出厂需改为beijing
        self.city = @"上海";
    }
    
}

/**
 *  读取天气
 */ 
- (void)judgeCity
{
    
    if (self.selectedCity.length) { // 如果有已选城市 (从右面回来) 加载已选城市
        
        [self loadWeatherWithCity:self.selectedCity];
       
    } else { // 没有已选城市则加载当前城市
       
        [self loadWeatherWithCity:self.city];
    }
    
}

- (void)loadWeatherWithCity:(NSString *)city
{
    if ([ANOffLineTool cityExists:city]) { // 有城市缓存
        // 从缓存读取数据加载数据
        NSDictionary *weathersDict = [ANOffLineTool weathersWithCity:city];
        [self dealingResult:weathersDict];
        
    } else { // 没缓存
        // 发送请求
        [self sendRequestWithCity:city];
    }
}



/**
 *  处理返回的数据
 *
 *  @param weathersDict 传进来的天气字典
 */
- (void)dealingResult:(NSDictionary *)weathersDict
{
    
    // 通过取出的字典创建模型
    self.weatherData = [ANWeatherData objectWithKeyValues:weathersDict];
#warning 只有刷新时才调用weatherView.weatherData 的setWeatherData方法
     self.weatherView.weatherData = self.weatherData;
    
    // 把字典数组转为模型数组
    self.dailyForecastArray = [ANDailyForecastM objectArrayWithKeyValuesArray:self.weatherData.daily_forecast];
    // 删除当天数据
    if (self.dailyForecastArray.count) {
        [self.dailyForecastArray removeObjectAtIndex:0];
    }
    
    // 设置导航栏

    self.navigationItem.title = self.weatherData.basic.city;

    
    // 重新加载tableView
    [self.tableView reloadData];
    
}


/**
 *  发送数据请求
 */
- (void)sendRequestWithCity:(NSString *)city
{
    
    // 1.创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 1.1 把apiKey包到请求头文件
    [mgr.requestSerializer setValue:ANApiKey forHTTPHeaderField:@"apikey"];
    
    // 1.2设置请求参数
    NSString *requsetURL = ANWeatherRequestUrl;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:city forKey:@"city"];
    ANLog(@"sendRequestWithCity-%@", city);
    
    // 2.发送请求
    [mgr GET:requsetURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         // 取出返回json所需部分 (取出字典数组里面的字典)
        NSMutableDictionary *weathersDict = [responseObject[@"HeWeather data service 3.0"] lastObject];
        
        // 处理返回的结果
        [self dealingResult:weathersDict];
        
        // 结束刷新
        [self.tableView.header endRefreshing];
        
        // 判断返回数据是否ok
        if ([weathersDict[@"status"] isEqualToString:@"ok"]) { // 如果ok把数据缓存到本地
            [ANOffLineTool saveWeathersDictWithJson:weathersDict];
        } else { // 失败提示HUD
            [MBProgressHUD showError:@"暂时获取不到当地天气数据"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"请检查网络状态"];
        // 结束刷新
        [self.tableView.header endRefreshing];
    }];
    
    
}


/**
 *  召唤左侧菜单
 */
- (void)callLeft
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

/**
 *  召唤右侧菜单
 */
- (void)callRight
{
    [self.sideMenuViewController presentRightMenuViewController];
   
}

/**
 *  获取所选城市天气
 */
- (void)getSelectedCityWeather:(NSNotification *)notification
{
    NSString *city = (NSString *)notification.userInfo;
    // 把市去掉 赋值给成员变量
    self.city = [city removeShi];
    self.navigationItem.title = self.city;
    // 开始刷新
    [self.tableView.header beginRefreshing];
    
}


/**
 *  获取位置
 */
- (void)getLocation
{
    
    if ([CLLocationManager locationServicesEnabled] && // 如果授权状态可用
        [CLLocationManager authorizationStatus] !=kCLAuthorizationStatusDenied  &&
        [CLLocationManager authorizationStatus] !=kCLAuthorizationStatusNotDetermined) {
        
        // 弹出提示HUD
        [MBProgressHUD showMessage:@"定位ing..."];
        // 开始定位
        [self.locationMgr startUpdatingLocation];
        
    } else if ([CLLocationManager locationServicesEnabled] &&
               ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined ||
               [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)) {// 如果定位开启但授权状态不可用
#warning 待改判断是否第一次打开
                   if (![ANOffLineTool isFirst]) { // 第一次打开软件
            // 请求授权
            [self.locationMgr requestWhenInUseAuthorization];

            // a
        } else {
            // 弹出提醒 并作点击ok跳转
            [self showAlertForTitle:@"授权状态不对" message:@"是否跳转到设置?"];
        }
        
    } else if (![CLLocationManager locationServicesEnabled]){ // 如果定位功能不可用
        
        // 弹出提醒 并作点击ok跳转
        [self showAlertForTitle:@"定位功能未开启" message:@"是否前往打开?"];
    }
}

/**
 *  弹出提醒设置定位功能
 */
-(void)showAlertForTitle:(NSString *)title message:(NSString *)message
{
    // 初始化alert控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    // cancel
    UIAlertAction  *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {

    }];

    // ok
    UIAlertAction  *ok = [UIAlertAction actionWithTitle:@"打开"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {

        // 跳转到设置定位页面
        NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }

    }];
    
    // 添加动作
    [alert addAction:cancel];
    [alert addAction:ok];
    
    // present出alert
    [self presentViewController:alert animated:YES completion:nil];
    
}



#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:@"定位失败请干点啥"];
    ANLog(@"定位失败%@", error);
}

/**
 *  授权状态发生改变时调用
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
    if (status == kCLAuthorizationStatusNotDetermined ||
        status == kCLAuthorizationStatusDenied) {// 如果授权状态为不确定或不允许就申请授权
        
//            [self.locationMgr requestWhenInUseAuthorization];

    } else {// 其他则提示授权失败
        
    }
}

/**
 *  位置发生改变时调用
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        // 隐藏HUD
        [MBProgressHUD hideHUD];

        CLPlacemark *pm = [placemarks firstObject];
        ANLog(@" %@\n %@\n %@\n %@\n %@\n %@\n %@\n ",
              pm.name, // eg. Apple Inc.
              pm.thoroughfare, // street address, eg. 1 Infinite Loop
              pm.subThoroughfare, // eg. 1
              pm.locality, // city, eg. Cupertino
              pm.subLocality, // neighborhood, common name, eg. Mission District
              pm.administrativeArea, // state, eg. CA
              pm.country // eg. United States
              );
        // 获取到的城市和当前城市不一样就开始刷新
        if (![pm.locality isEqualToString:self.city]){
            
            [self.tableView.header beginRefreshing];
        }
        
        
        // 把市字去掉 如果是州 就获取下级城市
        
        self.city = [pm.locality getCityName:pm.subLocality];
        
        
        // 设置导航栏
        self.navigationItem.title = pm.locality;
        
       
 
        if (error) { // 定位失败
            ANLog(@"%@", error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"定位失败请干点啥"];
        }
    }];
    

}

#pragma mark  UITableViewDataSource & UITableViewDelete
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

- (ANWeatherView *)weatherView
{
    if (!_weatherView) {
        _weatherView = [[ANWeatherView alloc] init];
    }
    return _weatherView;
}
- (void)dealloc
{
//    [ANNotificationCenter removeObserver:self];
    [ANNotificationCenter removeObserver:self];
}

@end
