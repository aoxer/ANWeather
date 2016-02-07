//
//  ANTodayTomorrowView.m
//  ANWeather
//
//  Created by a on 16/2/4.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANTodayTomorrowView.h"
#import "ANOffLineTool.h"
#import "ANDailyForecastM.h"
#import "ANWeatherData.h"

@interface ANTodayTomorrowView ()

// 今天
@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UILabel *todayQlty;
@property (weak, nonatomic) IBOutlet UILabel *todayMin;
@property (weak, nonatomic) IBOutlet UILabel *todayMax;
@property (weak, nonatomic) IBOutlet UILabel *todayCond;
@property (weak, nonatomic) IBOutlet UIImageView *todayIcon;
@property (weak, nonatomic) IBOutlet UILabel *todayWind;

// 明天
@property (weak, nonatomic) IBOutlet UIView *tomorrowView;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowMin;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowMax;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowCond;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowWind;





@end
@implementation ANTodayTomorrowView
#warning TODO 写入数据


+ (UIView *)today
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANTodayTomorrowView" owner:nil options:0 ] firstObject];
    
}

+ (UIView *)tomorrow
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANTodayTomorrowView" owner:nil options:0 ] lastObject];
    
}


/**
 *  读取天气
 */
- (void)setWeatherData:(ANWeatherData *)weather
{
    
    NSString *lastCity = [ANOffLineTool getLastCity];
    NSDictionary *weatherDict = [ANOffLineTool weathersWithCity:lastCity];
    
    NSArray *daysWeather = [ANDailyForecastM objectArrayWithKeyValuesArray:weatherDict[@"daily_forecast"]];
    
    // 空气质量
    ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:weatherDict];
    
    // 今明两天
    ANDailyForecastM *today = [daysWeather firstObject];
    ANDailyForecastM *tomorrow = [daysWeather objectAtIndex:1];
    
    
    // 今天
    // 天气
    NSString *txt = nil;
    if (weatherData.now.cond.txt) {
        txt = weatherData.now.cond.txt;
    } else {
        txt = weatherData.now.cond.txt_d;
    }
    self.todayCond.text = txt;
    
    // 最高最低温
    NSString *min = nil;
    NSString *max = nil;
    if ([ANSettingTool isC]) {
        min = [NSString stringWithFormat:@"%@°", today.tmp.min];
        max = [NSString stringWithFormat:@"%@°", today.tmp.max];
        
    } else {
        min = [NSString stringWithFormat:@"%ld°", ANFahrenheit(today.tmp.min)];
        max = [NSString stringWithFormat:@"%ld°", ANFahrenheit(today.tmp.max)];
        
    }
    self.todayMax.text = max;
    self.todayMin.text = min;
    
    // 空气质量
    NSString *qlty = weatherData.aqi.city.qlty;
    self.todayQlty.text = qlty;
    
    // 风
    NSString *dir = weatherData.now.wind.dir;
    NSString *spd = nil;
    if ([ANSettingTool isWindScale]) {
        if ([tomorrow.wind.sc isEqualToString:@"微风"]) {
            spd = [NSString stringWithFormat:@"%@", weatherData.now.wind.sc];
        } else {
            spd = [NSString stringWithFormat:@"%@级", weatherData.now.wind.sc];
        }
        
    } else {
        spd = [NSString stringWithFormat:@"%@kmh", weatherData.now.wind.spd];
    }
    self.todayWind.text = [NSString stringWithFormat:@"%@ %@", dir, spd];
    
    // 图标
    self.todayIcon.image = [UIImage imageNamed:today.cond.code_d];
    
    // 明天
    // 天气
    NSString *tomoTxt = nil;
    if (tomorrow.cond.txt) {
        tomoTxt = tomorrow.cond.txt;
    } else {
        tomoTxt = tomorrow.cond.txt_d;
    }
    self.tomorrowCond.text = tomoTxt;
    
    // 最高最低温
    NSString *tomoMin = nil;
    NSString *tomoMax = nil;
    if ([ANSettingTool isC]) {
        tomoMin = [NSString stringWithFormat:@"%@°", tomorrow.tmp.min];
        tomoMax = [NSString stringWithFormat:@"%@°", tomorrow.tmp.max];
        
    } else {
        tomoMin = [NSString stringWithFormat:@"%ld°", ANFahrenheit(tomorrow.tmp.min)];
        tomoMax = [NSString stringWithFormat:@"%ld°", ANFahrenheit(tomorrow.tmp.max)];
        
    }
    self.tomorrowMax.text = tomoMax;
    self.tomorrowMin.text = tomoMin;
    
    // 风
    NSString *tomoDir = tomorrow.wind.dir;
    NSString *tomoSpd = nil;
    if ([ANSettingTool isWindScale]) {
        
        if ([tomorrow.wind.sc isEqualToString:@"微风"]) {
            tomoSpd = [NSString stringWithFormat:@"%@", tomorrow.wind.sc];
        } else {
            tomoSpd = [NSString stringWithFormat:@"%@级", tomorrow.wind.sc];
        }
    } else {
        tomoSpd = [NSString stringWithFormat:@"%@kmh", tomorrow.wind.spd];
    }
    self.tomorrowWind.text = [NSString stringWithFormat:@"%@ %@", tomoDir, tomoSpd];
    
    // 图标
    self.tomorrowIcon.image = [UIImage imageNamed:tomorrow.cond.code_d];
    
    
    
}


@end
