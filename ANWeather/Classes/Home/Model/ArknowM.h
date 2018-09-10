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
@property (copy, nonatomic)NSString *cond_txt;// = 多云,
@property (copy, nonatomic)NSString *tmp;// = 26,
@property (copy, nonatomic)NSString *cond_code;// = 101

@end
