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


//@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *currentTmp;
@property (weak, nonatomic) IBOutlet UILabel *minTmp;
@property (weak, nonatomic) IBOutlet UILabel *maxTmp;

@property (weak, nonatomic) IBOutlet UILabel *MonthDay;

@end
@implementation ANTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
//    self.backgroundImageView.clipsToBounds = YES;
}

+ (instancetype)view
{
 
    return [[[NSBundle mainBundle] loadNibNamed:@"ANTopView" owner:nil options:0] lastObject];
}


- (void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;
    
    ANDailyForecastM *day1 = [ANDailyForecastM objectWithKeyValues:[weatherData.daily_forecast firstObject]];
    

    // 当前温度

    self.currentTmp.text = [NSString stringWithFormat:@"%@°",weatherData.now.tmp];
    // 最低温
    self.minTmp.text = [NSString stringWithFormat:@"%@°", day1.tmp.min];
    // 最高温
    self.maxTmp.text = [NSString stringWithFormat:@"%@°", day1.tmp.max];
    // 日期
    self.MonthDay.text = [self dateWithMonthDay:day1.date];
    
}

/**
 *  缩小最后一个字符
 */
- (NSAttributedString *)lastLetterSmall:(NSString *)text size:(CGFloat)size
{
    NSString *str = text;
    NSMutableAttributedString *AttrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.bounds = CGRectMake(0, 10,20, 20);
    [NSMutableAttributedString attributedStringWithAttachment:attach];
    
    
    [AttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(text.length, 1)];
    [AttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(text.length, 1)];

    return AttrStr;
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
