//
//  ArkBMKManager.h
//  
//
//  Created by 小华 on 2018/9/11.
//

#import <Foundation/Foundation.h>

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import <BaiduMapAPI_Cloud/BMKCloudPOIList.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>


@interface ArkBMKManager : NSObject<BMKGeneralDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic, strong)BMKMapManager * mapManager;
@property(nonatomic, strong)BMKGeoCodeSearch *geoSearch;
@property(nonatomic, strong)BMKLocationService *locationService; // 定位服务

+ (ArkBMKManager *)manager;

- (void)setupBMK;

@end
