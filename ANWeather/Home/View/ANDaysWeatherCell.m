//
//  ANDaysWeatherCell.m
//  ANWeather
//
//  Created by a on 15/12/28.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANDaysWeatherCell.h"
#import "ANWeatherData.h"

@interface ANDaysWeatherCell ()
/**
 *  星期几
 */
@property (weak, nonatomic) IBOutlet UILabel *week;
/**
 *  日期
 */
@property (weak, nonatomic) IBOutlet UILabel *date;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
/**
 *  最低温度
 */
@property (weak, nonatomic) IBOutlet UILabel *minTemp;
/**
 *  最高温度
 */
@property (weak, nonatomic) IBOutlet UILabel *maxTemp;

@end
@implementation ANDaysWeatherCell

- (void)awakeFromNib {
    self.backgroundColor = ANRandomColor;
}
 
- (void)setDailyForcast:(ANDailyForecastM *)dailyForcast
{
    _dailyForcast = dailyForcast;

    self.date.text = [self dateWithMonthDay:dailyForcast.date];
    self.maxTemp.text = dailyForcast.tmp.max;
    self.minTemp.text = dailyForcast.tmp.min;
    
    

}

- (NSString *)dateWithMonthDay:(NSString *)date
{
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
    NSString *MMDD = [NSString stringWithFormat:@"%@.%@", month, day];
    
    return MMDD;
}

/**
 *  根据xib创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"weather";
    ANDaysWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ANDaysWeatherCell" owner:nil options:0] lastObject];
    }
    
    return cell;
}


@end
