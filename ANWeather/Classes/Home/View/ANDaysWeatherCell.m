//
//  ANDaysWeatherCell.m
//  ANWeather
//
//  Created by a on 15/12/28.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANDaysWeatherCell.h"
#import "ArknowM.h"

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
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
}

-(void)setNowm:(ArknowM *)nowm
{
    _nowm=nowm;
    
    if ([ANSettingTool isC]) {
        
        self.maxTemp.text = [NSString stringWithFormat:@"%@°", nowm.tmp_max];
        self.minTemp.text = [NSString stringWithFormat:@"%@°", nowm.tmp_min];
    } else {
        
        self.maxTemp.text = [NSString stringWithFormat:@"%ld°", ANFahrenheit(nowm.tmp_max)];
        self.minTemp.text = [NSString stringWithFormat:@"%ld°", ANFahrenheit(nowm.tmp_min)];
    }
    
    self.week.text = [self weekDayFromDate:nowm.date];
    self.date.text = [self dateWithMonthDay:nowm.date];
    self.weatherIcon.image = [self getWeatherImageWithCondCode:nowm.cond_code_d];
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

/**
 *  根据日期计算星期几
 */
- (NSString *)weekDayFromDate:(NSString *)date
{
#warning 垃圾代码 待修缮
    NSString *year = [date substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day.integerValue];
    [comps setMonth:month.integerValue];
    [comps setYear:year.integerValue];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *NewDate = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:NewDate];
    NSInteger weekday = [weekdayComponents weekday];
   
    switch (weekday) {
        case 2:
            return @"一";
            break;
        case 3:
            return @"二";
            break;
        case 4:
            return @"三";
            break;
        case 5:
            return @"四";
            break;
        case 6:
            return @"五";
            break;
        case 7:
            return @"六";
            break;
        case 1:
            return @"日";
        default:
            break;
    }
    
    return @"日";
    
}



/**
 *  根据天气换图片
 */
- (UIImage *)getWeatherImageWithCondCode:(NSString *)code
{
    
    return [UIImage imageNamed:code];
    
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
