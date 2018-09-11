//
//  ANConst.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANConst.h"
/*
 https://www.heweather.com/documents/api/s6/weather-now
 appKey 05ebb69af005444dab53b381a86632eb
 */

// 账号信息

NSString * const ANWeatherRequestUrlnow = @"https://free-api.heweather.com/s6/weather/now";
NSString * const ANWeatherRequestUrlforecast = @"https://free-api.heweather.com/s6/weather/forecast";
NSString * const ANWeatherRequestUrlparameters = @"https://free-api.heweather.com/s6/air?parameters";

NSString * const ANApiKey = @"05ebb69af005444dab53b381a86632eb";
NSString * const ANApiusername=@"HE1809101150461656";
// 通知们
NSString * const ANGetLocationDidClickNotification = @"ANGetLocationDidClickNotification";
NSString * const ANCityDidClickNotification = @"ANCityDidClickNotification";
NSString * const ANCallLeftNotification = @"ANCallLeftNotification";
NSString * const ANCallRightNotification = @"ANCallRightNotification";
NSString * const ANCallHomeNotification = @"ANCallHomeNotification";
NSString * const ANWillShowMenu = @"ANWillShowMenuNotification";
NSString * const ANWillHideMenu = @"ANWillHideMenuNotification";




// 友盟AppKey
NSString * const ANUMAppKey = @"568bcd9ce0f55a549f0035b3";

// 微信分享
//NSString * const ANWXAppID = @"wx8ce94c6dad48a50e";
//NSString * const ANWXAppSecert = @"fc9b8bdf390b26a26e051df1e85d200a";
