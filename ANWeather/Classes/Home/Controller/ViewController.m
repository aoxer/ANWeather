 //
//  ViewController.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//
#import "AppDelegate.h"
#import <Accelerate/Accelerate.h>
#import "ViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ANWeatherView.h"
#import "MBProgressHUD+MJ.h"
#import "RESideMenu.h"
#import "ANDaysWeatherCell.h"
#import "MJRefresh.h"
#import "ANRightTableViewController.h"
#import "ANOffLineTool.h"
#import "ArknowM.h"
#import "MapViewController.h"

#import <CoreLocation/CoreLocation.h>


@interface ViewController ()<CLLocationManagerDelegate,ANAppDelegateRESideMenuDelegate>

/**
 *  已选城市城市
 */
@property (copy, nonatomic)NSString *city;

@property (strong, nonatomic)ANWeatherView *weatherView;

@property (strong, nonatomic)ArknowM *nowm;

/**
 *  位置管理者
 */
@property (strong, nonatomic)CLLocationManager *locationMgr;
@property (strong, nonatomic)CLGeocoder *geocoder;

@property (assign, nonatomic)CGPoint startPoint;
// 背景图片蒙版
@property (strong, nonatomic)UIView *cover;

/**
 * 此成员变量是为了修复摇一摇之后布局出现问题
 */
@property (assign, nonatomic)BOOL justShaked;

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
    
    // 判断城市并获取数据
    [self judgeCity];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

    // 隐藏状态栏
    [self prefersStatusBarHidden];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = [ANSettingTool isShakeEnable];

    //设置第一响应者
    [self becomeFirstResponder];

    
    self.view.backgroundColor = ANColor(222, 222, 222, 0.5);
    self.navigationController.navigationBar.shadowImage = [UIImage new];
   
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callLeft) andImageName:@"menu" andImageNameHighlight:@"menu"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callRight) andImageName:@"addMenu" andImageNameHighlight:@"addMenu"];
        
  
    
    // 如果是点击分享 就滚到最下并截屏分享
    if (self.isFromcare) {
        CGFloat offset = self.tableView.contentSize.height - self.tableView.bounds.size.height;
        if (offset > 0)
        {
            [self.tableView setContentOffset:CGPointMake(0, offset) animated:animated];
        }
        
        self.isFromcare = NO;
        
    }
    
}

#pragma mark 初始化方法

- (void)setupLastCity
{
    // 第一次打开设置默认城市
    if ([NSUserDefaults isFirst])
    {
        self.city = @"北京";
        ANLog(@"第一次");
    } else {
        self.city = [ANOffLineTool getLastCity].length ? [ANOffLineTool getLastCity] :@"北京";
        ANLog(@"第二次");
    }
    
    [self autoScrollShow];
    
}

/**
 *  初始化tableView
 */
- (void)setupTableView
{
    self.tableView.contentInset = UIEdgeInsetsMake(-20 , 0, 44*6 +20, 0);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.header.tintColor = ANRandomColor;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self sendRequestWithCity:self.city];
        
    }];
}

/**
 *  设置导航栏
 */
- (void)setupNavigaitonItem
{
    
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"nav"];
    
    // 设置导航栏文字颜色
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = ANColor(50, 50, 50, 1);
    [self.navigationController.navigationBar setTitleTextAttributes:attr];
    
}

/**
 *  设置天气控件
 */
- (void)SetupWeatherView
{
    ANWeatherView *weatherView = [[ANWeatherView alloc] init];
    CGRect rect = CGRectMake(0, 0, ANScreenWidth, ANScreenHeight);
    
    weatherView.frame = rect;
    
    [self.tableView addSubview:weatherView];
    
    self.weatherView = weatherView;
    
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



/**
 *  判断城市
 */
- (void)judgeCity
{
    // 加载天气
    if (self.isFromLeft) {// 如果是从左边来
        // 加载当前城市天气
        self.isFromLeft = NO;
    } else if (self.isFromRight){ // 如果从右边来
        // 加载所选城市天气
        self.city= self.selectedCity;
        self.isFromRight = NO;
    }
    
    [self loadWeatherWithCity:self.city];


}



/**
 *  发送数据请求
 */
- (void)sendRequestWithCity:(NSString *)city
{
    WeakSelf;
    
    [ArkReqTool reqWeatherData:city success:^(ArknowM *nowm) {
        
        weakSelf.nowm=nowm;
        
        weakSelf.weatherView.nowm = nowm;

        weakSelf.title=weakSelf.nowm.location;

        [weakSelf dealingResult];
        // 结束刷新
        [weakSelf.tableView.header endRefreshing];
        
         [ANOffLineTool saveWeathers:nowm];

    } failure:^{
        [weakSelf.tableView.header endRefreshing];

        [MBProgressHUD showError:@"暂时获取不到当地天气数据"];
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
//    [self.sideMenuViewController presentRightMenuViewController];
    
    MapViewController *map= [MapViewController new];
    map.nowm=self.nowm;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:map];
    [self presentViewController:navigationController animated:YES completion:nil];
}



/**
 *  获取所选城市天气
 */
- (void)getSelectedCityWeather:(NSNotification *)notification
{
    NSString *city = (NSString *)notification.userInfo;
    // 把市去掉 赋值给成员变量
    self.city = [city removeShi];
    
    self.title = self.city;
    // 开始刷新
    [self.tableView.header beginRefreshing];
    
}




#pragma mark 动作方法

/**
 *  处理拖动手势
 *
 *  @param recognizer 拖动手势识别器对象实例
 */
- (void)dragBtn:(UIPanGestureRecognizer *)recognizer
{
     // 1.挪动的距离
    CGPoint translation = [recognizer translationInView:recognizer.view];
    CGPoint center = recognizer.view.center;
    center.x += translation.x;
    center.y += translation.y;
    recognizer.view.center = center;
    self.startPoint = center;
    ANLog(@"%@", NSStringFromCGPoint(translation));
    // 清空移动的距离
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    
}



- (void)loadWeatherWithCity:(NSString *)city
{
    if ([ANOffLineTool cityExists:city] && [ANOffLineTool CityWeatherIsToday:city]) { // 有城市缓存并且为当天数据
        // 从缓存读取数据加载数据
        self.nowm=[ArknowM objectWithKeyValues:[ANOffLineTool weathersWithCity:city]];
        
        self.weatherView.nowm = self.nowm;
        
        self.title=self.nowm.location;
        // 设置导航栏
        [self dealingResult];
        
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
- (void)dealingResult
{
        // 设置背景图片并添加图片蒙版
    UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ANScreenWidth, ANScreenHeight)];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[self backGroungImageWithWeather:self.nowm]];
    [self.tableView.backgroundView addSubview:cover];
    self.cover = cover;
    // 重新加载tableView
    [self.tableView reloadData];
    
    [ANOffLineTool saveCurrentCity:self.city];
    
    [ANOffLineTool saveLastCity:self.city];
}

- (UIImage *)backGroungImageWithWeather:(ArknowM *)nowm
{
    NSString *txt = nil;
    if (nowm.cond_txt_d) {
        txt = nowm.cond_txt_d;
    } else {
        txt = nowm.cond_txt_n;
    }
    
    UIImage *image = [UIImage imageNamed:@"clear.jpg"];
    if ([txt isEqualToString:@"晴"]) {
        image = [UIImage imageNamed:@"clear.jpg"];
        
        return image;
    } else if ([txt hasSuffix:@"雨"]){
        
        image = [UIImage imageNamed:@"rain_d_portrait.jpg"];
        return image;
    } else if ([txt hasSuffix:@"阴"]){
        
        image = [UIImage imageNamed:@"yintian.jpg"];
        return image;
    } else if ([txt hasSuffix:@"阴"]){
        
        image = [UIImage imageNamed:@"yintian.jpg"];
        return image;
    } else if ([txt hasSuffix:@"暴雨"]){
        
        image = [UIImage imageNamed:@"storm_d_portrait.jpg"];
        return image;
    }else if ([txt hasSuffix:@"云"]){
        
        image = [UIImage imageNamed:@"cloudy_d_portrait.jpg"];

        return image;
    } else if ([txt hasSuffix:@"雪"]){
        
        image = [UIImage imageNamed:@"snow_d_portrait.jpg"];
        

        return image;
    } else if ([txt hasSuffix:@"雾"]){
        
        image = [UIImage imageNamed:@"foggy_d_portrait.jpg"];
        

        return image;
    } else if ([txt hasSuffix:@"霾"]){
        
        image = [UIImage imageNamed:@"foggy_d_portrait.jpg"];
        

        return image;
    }
    

     return image;
}




/**
 *  获取位置
 */
- (void)getLocation
{
    // 开始更新
    [self.locationMgr startUpdatingLocation];
    
    // 如果非第一次打开时 定位功能关闭
    if (![NSUserDefaults isFirst] && ![CLLocationManager locationServicesEnabled]) {
        [MBProgressHUD showError:@"定位功能关闭 请开启"];
    } else if (![NSUserDefaults isFirst] && ANAuthorizationDenied) {// 如果非第一次打开时 定位功能授权状态不对
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
    // 0.菊花
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
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
        // 设置导航栏标题
        self.city=locCity;
        
        [self loadWeatherWithCity:locCity];

        // 0.菊花
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

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


#pragma mark scrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.tableView.contentSize = CGSizeMake(self.weatherView.size.width, self.weatherView.size.height - 20);
    
}

 
#pragma scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha =  offsetY / 200;
    [self.navigationController.navigationBar lt_setBackgroundColor:[ANNavBarColor colorWithAlphaComponent:alpha]];
    
//    if (alpha> 0.8) {
//        alpha = 0.8;
//    }
    
//    self.cover.backgroundColor = ANColor(50, 50, 50, alpha);
    
    // 下拉导航栏隐藏
    if (scrollView.contentOffset.y < 0) {
        self.navigationController.navigationBar.hidden = YES;
    } else {
        self.navigationController.navigationBar.hidden = NO;
    }
    
    // 模糊背景
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"snow_d_portrait"]];
//    // create gaussian blurcfilter
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:inputImage forKey:kCIInputImageKey];
//    [filter setValue:[NSNumber numberWithFloat:alpha*1.3] forKey:@"inputRadius"];
//    // blur image
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    self.tableView.backgroundView = imageView;

}

- (void)autoScrollShow
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:3 animations:^{
            UIView.animationRepeatCount  = 3;
            [self.tableView setContentOffset:CGPointMake(0, 55) animated:YES];
        } completion:^(BOOL finished) {

        }];
        [UIView animateWithDuration:3 animations:^{
            
        }];
    });

   
}


#pragma mark <ANRightTableViewControllerDelegate>
- (void)rightTableViewControllerClickGetLocation
{
    [self getLocation];
}

#pragma mark ANAppDelegateRESideMenuDelegate
//- (void)appDelegateRESideMenuWillShowMenuViewController
//{
//    [UIView animateWithDuration:1 animations:^{
//        self.menu.alpha = 0;
//    } completion:^(BOOL finished) {
//        self.menu.hidden = YES;
//
//    }];
//}
//
//
//- (void)appDelegateRESideMenuWillHideMenuViewController
//{
//    self.menu.alpha = 0;
//    [UIView animateWithDuration:1 animations:^{
//        self.menu.hidden = NO;
//        self.menu.alpha = 1;
//    } completion:^(BOOL finished) {
//        
//    }];
//
//}

#pragma mark 摇一摇
//- (BOOL)canBecomeFirstResponder {
//    return YES;
//}
//
//
////在响应摇一摇动作方法内得到屏幕截图
//-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event
//{
//    if(motion == UIEventSubtypeMotionShake)
//    {
//       // 该功能是在用户打开分享面板时，将要分享的图像内容替换为当前应用截图，要使用该功能需要将 UMSocial_ScreenShot_Sdk文件夹添加到工程的中，示例如下:
//        
//        UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
//        [UMSocialSnsService presentSnsIconSheetView:self appKey:ANUMAppKey shareText:@"分享文字" shareImage:image shareToSnsNames:nil delegate:nil];
//
//    }
//    
//    [UMSocialShakeService unShakeToSns];
//
//}




@end
