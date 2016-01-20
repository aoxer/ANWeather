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
@property (weak, nonatomic) IBOutlet UILabel *CF;

@property (weak, nonatomic) IBOutlet UILabel *MonthDay;

@end
@implementation ANTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}


- (void)setup
{
    
}

+ (instancetype)view
{
 
    return [[[NSBundle mainBundle] loadNibNamed:@"ANTopView" owner:nil options:0] lastObject];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = rect;
    gradient.colors = [NSArray arrayWithObjects:(id)ANColor(255, 255, 255, 0).CGColor,
                       (id)ANColor(100, 100, 100, 0.95).CGColor,nil];
    [self.layer insertSublayer:gradient atIndex:0];
    

}

- (void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;
    ANDailyForecastM *day1 = [ANDailyForecastM objectWithKeyValues:[weatherData.daily_forecast firstObject]];
    
 

    // 当前温度
    NSString *nowTmp = weatherData.now.tmp;
    
    if ([ANSettingTool isC]) {
        
        // 摄氏度
        self.CF.text = @"°C";
        // 当前温度
        self.currentTmp.text = [NSString stringWithFormat:@"%@",nowTmp];
        // 最低温
        self.minTmp.text = [NSString stringWithFormat:@"%@°", day1.tmp.min];
        // 最高温
        self.maxTmp.text = [NSString stringWithFormat:@"%@°", day1.tmp.max];
    } else {
        
        // 华氏度
        self.CF.text = @"°F";
        // 当前温度
        self.currentTmp.text = [NSString stringWithFormat:@"%ld", ANFahrenheit(nowTmp)];
        // 最低温
        self.minTmp.text = [NSString stringWithFormat:@"%ld°", ANFahrenheit(day1.tmp.min)];
        // 最高温
        self.maxTmp.text = [NSString stringWithFormat:@"%ld°", ANFahrenheit(day1.tmp.max)];
    };
     
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

- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = self.bounds;
    newShadow.frame = newShadowFrame;
    ANLog(@"%@", NSStringFromCGRect(self.bounds));
    //添加渐变的颜色组合
    newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,(id)[UIColor blackColor].CGColor,nil];
    return newShadow;
}@end
