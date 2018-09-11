//
//  ArkBMKManager.m
//  
//
//  Created by 小华 on 2018/9/11.
//

#import "ArkBMKManager.h"

@implementation ArkBMKManager

+ (ArkBMKManager *)manager
{
    static ArkBMKManager *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[self alloc] init];
    });
    
    return sharedInstace;
}


- (void)setupBMK
{
    self.mapManager=[[BMKMapManager alloc]init];
    NSString *bmkKey=@"I6ieuELYCi6XrgIkcv9u1BkOynRm5Nvk";
    BOOL ret = [self.mapManager start:bmkKey generalDelegate:self];
    
    
    if (!ret) {
        ANLog(@"百度地图manager start failed!");
    }
}

#pragma mark BMKGeneralDelegate
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        ANLog(@"百度地图授权成功");
        self.locationService = [[BMKLocationService alloc] init];
        self.locationService.delegate = self;
        [self.locationService startUserLocationService];
    }
    else {
        ANLog(@"百度地图授权失败onGetPermissionState %d",iError);
    }
}

#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    // 将获取到的经纬度保存到defaults中(在城市范围内，以后都可以拉取到这个城市的数据)
    [kUserDefaults setValue:[NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude] forKey:USERLNG];
    [kUserDefaults setValue:[NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude] forKey:USERLAT];
    [kUserDefaults synchronize];
    
    // 进行逆地理编码，获得当前位置
    [self beginReCode];
}

// 进行逆地理编码，获得当前位置
- (void)beginReCode
{
    self.geoSearch = [[BMKGeoCodeSearch alloc] init];
    self.geoSearch.delegate = self;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
    NSString *longitudeString =[kUserDefaults objectForKey:USERLNG];
    NSString *latitudeString =[kUserDefaults objectForKey:USERLAT];
    
    if (longitudeString != nil && latitudeString != nil) {
        pt = (CLLocationCoordinate2D){[latitudeString floatValue], [longitudeString floatValue]};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [self.geoSearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag) {
        //         ANLog(@"反geo检索发送成功");
    } else {
        ANLog(@"反geo检索发送失败");
    }
}

#pragma mark BMKGeoCodeSearchDelegate
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error) {
        ANLog(@"逆地理编码失败,%d", error);
    } else {
        // 逆地理编码成功
        BMKPoiInfo *info= result.poiList.firstObject;
        [kUserDefaults setValue:info.name forKey:USERPoiname];
        [kUserDefaults setValue:result.addressDetail.province forKey:USERProvince];
        [kUserDefaults setValue:result.addressDetail.city forKey:USERCity];
        [kUserDefaults setValue:result.addressDetail.district forKey:USERDistrict];
        [kUserDefaults setValue:result.address forKey:USERAddress];
        [kUserDefaults synchronize];
    }
    
}
@end
