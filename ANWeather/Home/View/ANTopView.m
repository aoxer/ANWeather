//
//  ANTopView.m
//  ANWeather
//
//  Created by a on 15/12/31.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTopView.h"
#import "ANWeatherData.h"

@interface ANTopView ()


@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentTmp;
@property (weak, nonatomic) IBOutlet UILabel *minTmp;
@property (weak, nonatomic) IBOutlet UILabel *maxTmp;

@property (weak, nonatomic) IBOutlet UILabel *MonthDay;

@end
@implementation ANTopView

- (void)awakeFromNib
{
    self.backgroundImageView.clipsToBounds = YES;
}

+ (instancetype)view
{
 
    return [[[NSBundle mainBundle] loadNibNamed:@"ANTopView" owner:nil options:0] lastObject];
}


- (void)setWeatherData:(ANWeatherData *)weatherData
{
    
    ANDailyForecastM *day1 = [ANDailyForecastM objectWithKeyValues:[weatherData.daily_forecast firstObject]];
    
    // 背景图片
    
    // 当前温度
    self.currentTmp.text = weatherData.now.tmp;
    // 最低温
    self.minTmp.text = day1.tmp.min;
    // 最高温
    self.maxTmp.text = day1.tmp.max;
    // 日期
    self.MonthDay.text = [self dateWithMonthDay:day1.date];
    
}


/**
 *  把日期转为月日
 */
- (NSString *)dateWithMonthDay:(NSString *)date
{
    
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
    NSString *MMDD = [NSString stringWithFormat:@"%@.%@", month, day];
    
    return MMDD;
}


@end
