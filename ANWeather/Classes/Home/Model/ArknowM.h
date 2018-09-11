//
//  ArknowM.h
//  ANWeather
//
//  Created by 小华 on 2018/9/10.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArknowM : NSObject
@property (copy, nonatomic)NSString *hum;// = 59,
@property (copy, nonatomic)NSString *fl;// = 28,
@property (copy, nonatomic)NSString *cloud;// = 50,
@property (copy, nonatomic)NSString *pres;// = 1016,
@property (copy, nonatomic)NSString *vis ;//= 34,
@property (copy, nonatomic)NSString *wind_dir;// = 东风,
@property (copy, nonatomic)NSString *wind_spd;// = 1,
@property (copy, nonatomic)NSString *wind_deg ;//= 85,
@property (copy, nonatomic)NSString *wind_sc;// = 0,
@property (copy, nonatomic)NSString *pcpn;// = 0.0,
@property (copy, nonatomic)NSString *cond_txt_d;// = 多云,
@property (copy, nonatomic)NSString *cond_txt_n;// = 多云,
@property (copy, nonatomic)NSString *tmp;// = 26,
@property (copy, nonatomic)NSString *cond_code_d;// = 101
@property (copy, nonatomic)NSString *date;
@property (copy, nonatomic)NSString *tmp_max;
@property (copy, nonatomic)NSString *tmp_min;

//pm

@property (copy, nonatomic)NSString *qlty;// = 优,
@property (copy, nonatomic)NSString *pm25;// = 11,
@property (copy, nonatomic)NSString *aqi;// = 40,
@property (copy, nonatomic)NSString *no2 ;//= 33,
@property (copy, nonatomic)NSString *co;// = 0.6,
@property (copy, nonatomic)NSString *pm10;// = 40,
@property (copy, nonatomic)NSString *main;// = -,
@property (copy, nonatomic)NSString *so2 ;//= 6,
@property (copy, nonatomic)NSString *o3;// = 65,
@property (copy, nonatomic)NSString *pub_time;// = 2018 - 09 - 11 10 : 00

@property (strong, nonatomic)NSArray *air_now_station;
@property (strong, nonatomic)NSArray *daily_forecast;

@property (copy, nonatomic)NSString *lon;// = 121.4,
@property (copy, nonatomic)NSString *asid ;//= CNA1141,
@property (copy, nonatomic)NSString *air_sta;// = 普陀,
@property (copy, nonatomic)NSString *lat ;//= 31.238,

@property (copy, nonatomic)NSString *location;// = 上海,
@property (copy, nonatomic)NSString *cnty;// = 中国,
@property (copy, nonatomic)NSString *tz;// = +8.00,
@property (copy, nonatomic)NSString *admin_area;// = 上海,
@property (copy, nonatomic)NSString *parent_city;// = 上海,
@property (copy, nonatomic)NSString *cid;// = CN101020100



@end
