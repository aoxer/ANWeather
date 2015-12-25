//
//  ViewController.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

/*
{
HeWeather data service 3.0 = [
{
    hourly_forecast = [
    {
        pres = 1020,
        wind = {
            dir = 西北风,
            deg = 309,
            sc = 微风,
            spd = 5
        },
        hum = 39,
        tmp = 2,
        pop = 0,
        date = 2015-12-25 10:00
    },
    {
        pres = 1018,
        wind = {
            dir = 西风,
            deg = 265,
            sc = 微风,
            spd = 7
        },
        hum = 28,
        tmp = 7,
        pop = 0,
        date = 2015-12-25 13:00
    },
    {
        pres = 1017,
        wind = {
            dir = 西南风,
            deg = 222,
            sc = 微风,
            spd = 8
        },
        hum = 35,
        tmp = 6,
        pop = 0,
        date = 2015-12-25 16:00
    },
    {
        pres = 1017,
        wind = {
            dir = 西风,
            deg = 266,
            sc = 微风,
            spd = 5
        },
        hum = 42,
        tmp = 4,
        pop = 0,
        date = 2015-12-25 19:00
    },
    {
        pres = 1018,
        wind = {
            dir = 西北风,
            deg = 321,
            sc = 微风,
            spd = 6
        },
        hum = 44,
        tmp = 2,
        pop = 0,
        date = 2015-12-25 22:00
    }
                       ],
    status = ok,
    daily_forecast = [
    {
        astro = {
            ss = 16:54,
            sr = 07:33
        },
        pres = 1017,
        tmp = {
            max = 4,
            min = -4
        },
        wind = {
            dir = 无持续风向,
            deg = 245,
            sc = 微风,
            spd = 4
        },
        hum = 26,
        date = 2015-12-25,
        vis = 10,
        cond = {
            txt_d = 霾,
            code_n = 501,
            code_d = 502,
            txt_n = 雾
        },
        pcpn = 0.0,
        pop = 0
    },
    {
        astro = {
            ss = 16:55,
            sr = 07:34
        },
        pres = 1028,
        tmp = {
            max = 5,
            min = -6
        },
        wind = {
            dir = 北风,
            deg = 132,
            sc = 3-4,
            spd = 15
        },
        hum = 33,
        date = 2015-12-26,
        vis = 10,
        cond = {
            txt_d = 晴,
            code_n = 101,
            code_d = 100,
            txt_n = 多云
        },
        pcpn = 0.0,
        pop = 1
    },
    {
        astro = {
            ss = 16:55,
            sr = 07:34
        },
        pres = 1035,
        tmp = {
            max = 0,
            min = -6
        },
        wind = {
            dir = 无持续风向,
            deg = 208,
            sc = 微风,
            spd = 6
        },
        hum = 51,
        date = 2015-12-27,
        vis = 10,
        cond = {
            txt_d = 多云,
            code_n = 100,
            code_d = 101,
            txt_n = 晴
        },
        pcpn = 0.0,
        pop = 1
    },
    {
        astro = {
            ss = 16:56,
            sr = 07:34
        },
        pres = 1034,
        tmp = {
            max = 2,
            min = -4
        },
        wind = {
            dir = 无持续风向,
            deg = 161,
            sc = 微风,
            spd = 10
        },
        hum = 32,
        date = 2015-12-28,
        vis = 10,
        cond = {
            txt_d = 多云,
            code_n = 104,
            code_d = 101,
            txt_n = 阴
        },
        pcpn = 0.0,
        pop = 0
    },
    {
        astro = {
            ss = 16:57,
            sr = 07:35
        },
        pres = 1027,
        tmp = {
            max = 2,
            min = -5
        },
        wind = {
            dir = 无持续风向,
            deg = 128,
            sc = 微风,
            spd = 3
        },
        hum = 43,
        date = 2015-12-29,
        vis = 10,
        cond = {
            txt_d = 阴,
            code_n = 100,
            code_d = 104,
            txt_n = 晴
        },
        pcpn = 0.0,
        pop = 0
    },
    {
        astro = {
            ss = 16:57,
            sr = 07:35
        },
        pres = 1029,
        tmp = {
            max = 5,
            min = -6
        },
        wind = {
            dir = 无持续风向,
            deg = 322,
            sc = 微风,
            spd = 3
        },
        hum = 27,
        date = 2015-12-30,
        vis = 10,
        cond = {
            txt_d = 晴,
            code_n = 100,
            code_d = 100,
            txt_n = 晴
        },
        pcpn = 0.0,
        pop = 0
    },
    {
        astro = {
            ss = 16:58,
            sr = 07:35
        },
        pres = 1025,
        tmp = {
            max = 6,
            min = -6
        },
        wind = {
            dir = 无持续风向,
            deg = 307,
            sc = 微风,
            spd = 10
        },
        hum = 26,
        date = 2015-12-31,
        vis = 10,
        cond = {
            txt_d = 晴,
            code_n = 100,
            code_d = 100,
            txt_n = 晴
        },
        pcpn = 0.0,
        pop = 0
    }
                      ],
    now = {
        pres = 1020,
        tmp = -6,
        wind = {
            dir = 西南风,
            deg = 120,
            sc = 4-5,
            spd = 22
        },
        hum = 99,
        vis = 1,
        cond = {
            txt = 雾,
            code = 501
        },
        fl = -7,
        pcpn = 0
    },
    aqi = {
        city = {
            qlty = 严重污染,
            pm25 = 410,
            aqi = 441,
            co = 7,
            no2 = 113,
            o3 = 7,
            pm10 = 293,
            so2 = 11
        }
    },
    basic = {
        cnty = 中国,
        id = CN101010100,
        lat = 39.904000,
        city = 北京,
        lon = 116.391000,
        update = {
            loc = 2015-12-25 08:52,
            utc = 2015-12-25 00:52
        }
    },
    suggestion = {
        drsg = {
            brf = 冷,
            txt = 天气冷，建议着棉服、羽绒服、皮夹克加羊毛衫等冬季服装。年老体弱者宜着厚棉衣、冬大衣或厚羽绒服。
        },
        flu = {
            brf = 较易发,
            txt = 天气转凉，空气湿度较大，较易发生感冒，体质较弱的朋友请注意适当防护。
        },
        sport = {
            brf = 较不宜,
            txt = 有雾或霾且室外很冷，建议适当停止户外运动，选择在室内进行运动，以避免吸入过多雾中有害物质，损害健康。
        },
        comf = {
            brf = 较不舒适,
            txt = 白天天气阴沉，您会感觉偏冷，不很舒适，请注意添加衣物，以防感冒。
        },
        trav = {
            brf = 较不宜,
            txt = 空气质量差，不适宜旅游
        },
        cw = {
            brf = 不宜,
            txt = 不宜洗车，未来24小时内有霾，如果在此期间洗车，会弄脏您的爱车。
        },
        uv = {
            brf = 最弱,
            txt = 属弱紫外线辐射天气，无需特别防护。若长期在户外，建议涂擦SPF在8-12之间的防晒护肤品。
        }
    }
}
                              ]
}
*/


#import "ViewController.h"
#import "ANWeatherItemView.h"
#import "ANWindSpeedItemView.h"
#import "ANPM25ItemView.h"
#import "ANTempItemView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "ANWeatherData.h"

#define MARGIN 5
#define ANMaxRow 3
#define ANMaxCol 2
@interface ViewController ()
@property (strong, nonatomic)NSMutableArray *items;
@property (strong, nonatomic)ANWeatherItemView *weatherItem;
@property (strong, nonatomic)ANWindSpeedItemView *speedItem;
@property (strong, nonatomic)ANPM25ItemView *pm25Item;
@property (strong, nonatomic)ANTempItemView *tempItem;

@property (strong, nonatomic)ANWeatherData *weatherData;
@end

@implementation ViewController
/**
 *  懒加载数组
 */
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    
    [self addItem];
    
    [self sendRequest];
}

- (void)sendRequest
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
    [param setValue:@"beijing" forKey:@"city"];
    
    [mgr GET:requsetURL parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ANLog(@"%@", responseObject);
        
        NSArray *array = [ANWeatherData objectArrayWithKeyValuesArray:responseObject[@"HeWeather data service 3.0"]];
        NSMutableDictionary *dict =  [NSMutableDictionary dictionary];
        dict[@"hourly_forecast"] = [ANWeatherData keyValuesArrayWithObjectArray:array];
        
        [dict writeToFile:@"/Users/a/Desktop/weather.plist" atomically:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ANLog(@"%@",error);
    }];
    
}



/**
 *  添加方块元素
 */
- (void)addItem
{
    // 天气
    ANWeatherItemView *weatherItem = [[ANWeatherItemView alloc] init];
    weatherItem.backgroundColor = ANRandomColor;
    [self.view addSubview:weatherItem];
    self.weatherItem = weatherItem;
    [self.items addObject:weatherItem];
    
    // pm2.5
    ANPM25ItemView *pm25Item = [[ANPM25ItemView alloc] init];
    pm25Item.backgroundColor = ANRandomColor;
    [self.view addSubview:pm25Item];
    self.pm25Item = pm25Item;
    [self.items addObject:pm25Item];
    
    // 温度
    ANTempItemView *tempItem = [[ANTempItemView alloc] init];
    tempItem.backgroundColor = ANRandomColor;
    [self.view addSubview:tempItem];
    self.tempItem = tempItem;
    [self.items addObject:tempItem];
    
    // 风速
    ANWindSpeedItemView *speedItem = [[ANWindSpeedItemView alloc] init];
    speedItem.backgroundColor = ANRandomColor;
    [self.view addSubview:speedItem];
    self.speedItem = speedItem;
    [self.items addObject:speedItem];
    
    NSInteger count = self.items.count;
    for (int i = 0; i<count; i++) {
        
        int row = i / ANMaxCol;
        int col = i % ANMaxCol;
        
        UIView *view = self.items[i];
        
        view.width = (ANScreenWidth - MARGIN * 3) / ANMaxCol;
        view.height = (ANScreenHeight - 74 - MARGIN * 3) / ANMaxRow;
        view.x = MARGIN + col * (view.width + MARGIN);
        view.y = 74 + row * (view.height + MARGIN);
    }
}



@end
