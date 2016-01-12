 //
//  ViewController.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//
#import <Accelerate/Accelerate.h>
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


@interface ViewController ()<CLLocationManagerDelegate>

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
 *  位置管理者
 */
@property (strong, nonatomic)CLLocationManager *locationMgr;
@property (strong, nonatomic)CLGeocoder *geocoder;

@property (strong, nonatomic)UIImageView *backGroungImageView;
@property (weak, nonatomic)MBProgressHUD *HUD;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 设置上一次城市
    [self setupLastCity];
    
    // 设置tableView
    [self setupTableView];
    
    // 设置导航栏
    [self setupNavigaitonItem];
    
    // 设置天气View
    [self SetupWeatherView];
    
    // 如果是iOS8+ 请求位置授权
    [self requestAuthorizaiton];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 判断是否为当天数据
    [self judgeCity];
}


/**
 *  判断城市
 */
- (void)judgeCity
{
    // 加载天气
    if (self.isFromLeft) {// 如果是从左边来
        
        // 加载当前城市天气
        [self loadWeatherWithCity:self.city];
        self.isFromLeft = NO;
        
    } else if (self.isFromRight){ // 如果从右边来
        
        // 加载所选城市天气
        [self loadWeatherWithCity:self.selectedCity];
        self.isFromRight = NO;
        
    } else{
        
        [self sendRequestWithCity:self.city];
    }
}
#pragma mark 初始化方法
/**
 *  初始化tableView
 */
- (void)setupTableView
{
//    _backGroungImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lake"]];
    
    self.tableView.backgroundColor = ANColor(131, 131, 171, 1);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = self.backGroungImageView;
    self.tableView.header.backgroundColor = ANColor(131, 131, 171, 1);
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self sendRequestWithCity:self.navigationItem.title];
        
    }];
}

/**
 *  设置导航栏
 */
- (void)setupNavigaitonItem
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callLeft) andImageName:@"menu" andImageNameHighlight:@"menu"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callRight) andImageName:@"adds" andImageNameHighlight:@"adds"];
    self.navigationController.navigationBar.barTintColor = ANColor(40, 40, 40, 0.3);
    // 设置导航栏文字颜色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:attr];
    
   
}


/**
 *  设置天气控件
 */
- (void)SetupWeatherView
{
   CGRect rect = CGRectMake(0, 0, ANScreenWidth, self.view.bounds.size.height - 44);
     self.weatherView.frame = rect;
    
    
    [self.tableView addSubview:_weatherView];
    

}

/**
 *  如果是iOS8+ 请求位置授权
 */
- (void)requestAuthorizaiton
{
    if (IOS_8_ABOVE) {
        [self.locationMgr requestWhenInUseAuthorization];
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



- (void)loadWeatherWithCity:(NSString *)city
{
    if ([ANOffLineTool cityExists:city] && [ANOffLineTool CityWeatherIsToday:city]) { // 有城市缓存并且为当天数据
        // 从缓存读取数据加载数据
        NSDictionary *weathersDict = [ANOffLineTool weathersWithCity:city];
        [self dealingResult:weathersDict];
        
    } else { //
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
    // 开始更新
    [self.locationMgr startUpdatingLocation];
    
    // 如果非第一次打开时 定位功能关闭
    if (![ANOffLineTool isFirst] && ![CLLocationManager locationServicesEnabled]) {
        [MBProgressHUD showError:@"定位功能关闭 请开启"];
    } else if (![ANOffLineTool isFirst] && ANAuthorizationDenied) {// 如果非第一次打开时 定位功能授权状态不对
       [MBProgressHUD showError:@"定位功能关闭 请开启"];
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
/**
 *  位置发生改变时调用
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
     [MBProgressHUD showMessage:@"定位ing"];
    
    CLLocation *location = [locations lastObject];

    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
      
        CLPlacemark *pm = [placemarks firstObject];
        ANLog(@"  %@\n %@\n %@\n %@\n %@\n ",
              pm.subThoroughfare, // eg. 1
              pm.locality, // city, eg. Cupertino
              pm.subLocality, // neighborhood, common name, eg. Mission District
              pm.administrativeArea, // state, eg. CA
              pm.country // eg. United States
              );
        
        // 获取到的城市开始刷新
        NSString *locCity = [pm.locality getCityName:pm.locality];
        self.city = locCity;
        self.navigationItem.title = locCity;
        [self.tableView.header beginRefreshing];
   
        if (error) { // 定位失败
             [MBProgressHUD showError:@"定位失败请手动选择城市"];
        }
    }];
    
    [self.locationMgr stopUpdatingLocation];

}

#pragma mark 懒加载们

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
        // 成为CoreLocation管理者的代理监听获取到的位置
        _locationMgr.delegate = self;
        // 更新位置为每1000m
        _locationMgr.distanceFilter = 1000.f;
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

- (UIImageView *)backGroungImageView
{
    if (!_backGroungImageView) {
        _backGroungImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lake"]];
    }
    return _backGroungImageView;
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.tableView.contentSize = CGSizeMake(self.weatherView.size.width, self.weatherView.size.height - 20);
    
    ANLog(@"%@", NSStringFromCGSize(self.weatherView.size));
}

- (void)HUDWithText:(NSString *)text
{
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    _HUD.delegate = self;
    
    _HUD.labelText = text;
    [_HUD hide:YES afterDelay:2];
}


#pragma scrollViewDelegate
#warning TODO 模糊
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    GPUImageGaussianBlurFilter *blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
//    blurFilter.blurRadiusInPixels = 2.0;
//    UIImage *backGroundImage = [UIImage imageNamed:@"lake"];
//   self.backGroungImageView.image = [blurFilter imageByFilteringImage:backGroundImage];
    
}

#pragma mark <ANRightTableViewControllerDelegate>
- (void)rightTableViewControllerClickGetLocation
{
    [self getLocation];
}

@end

















