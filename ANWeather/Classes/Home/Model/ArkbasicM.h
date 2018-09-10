//
//  ArkbasicM.h
//  ANWeather
//
//  Created by 小华 on 2018/9/10.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArkbasicM : NSObject

@property (copy, nonatomic)NSString *location;// = 上海,
@property (copy, nonatomic)NSString *cnty;// = 中国,
@property (copy, nonatomic)NSString *tz;// = +8.00,
@property (copy, nonatomic)NSString *admin_area;// = 上海,
@property (copy, nonatomic)NSString *lon;// = 121.47264099,
@property (copy, nonatomic)NSString *lat;// = 31.23170662,
@property (copy, nonatomic)NSString *parent_city;// = 上海,
@property (copy, nonatomic)NSString *cid ;//= CN101020100

@end
