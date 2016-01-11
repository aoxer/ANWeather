//
//  ANPM25ItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANPM25ItemView.h"
#import "ANWeatherData.h"
#import "MSSimpleGauge.h"

@interface ANPM25ItemView ()


/**
 *  pm2.5的label
 */
@property (weak, nonatomic) IBOutlet UILabel *pm2_5;

/**
 *  空气质量的label
 */
@property (weak, nonatomic) IBOutlet UILabel *qltyLabel;


/**
 *  仪表盘view
 */
@property (weak, nonatomic) IBOutlet UIView *GaugeView;
/**
 *  仪表盘
 */
@property (strong, nonatomic) UIView *bigGauge;


@end

@implementation ANPM25ItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setup];
    }
    return self;
}


- (void)setup
{
    // 指针颜色
//    self.bigGauge.needleView.needleColor = ANRandomColor;
    // 表盘
#warning TODO
//    self.bigGauge = [[MSSimpleGauge alloc] init];
//    self.bigGauge.backgroundColor = [UIColor clearColor];
//    self.bigGauge.startAngle = 0;
//    self.bigGauge.endAngle = 90;
//    [self.GaugeView addSubview:self.bigGauge];
 
//    self.bigGauge = [[UIView alloc] initWithFrame:self.GaugeView.bounds];
//    self.bigGauge.backgroundColor = [UIColor clearColor];
////    self.bigGauge.startAngle = 0;
////    self.bigGauge.endAngle = 360;
//    self.bigGauge.backgroundColor = [UIColor clearColor];
//    [self addSubview:self.bigGauge];

}

+ (instancetype)view
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ANPM25ItemView" owner:nil options:0 ] lastObject];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANLog(@"%@", NSStringFromClass([self class]));
}

- (void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;
    CGFloat pm2_5 = weatherData.aqi.city.pm25.doubleValue;

    //pm2.5
    if (!weatherData.aqi.city.pm25.length) {
        self.pm2_5.text = @"";
    } else {
        self.pm2_5.text = [NSString stringWithFormat:@"PM2.5 %@", weatherData.aqi.city.pm25];
    }
    
    // 空气质量
    if (!weatherData.aqi.city.qlty.length) {
        self.qltyLabel.text = @"优";
    } else {
        self.qltyLabel.text = weatherData.aqi.city.qlty;
    }
    
    // 指针
//    [self.bigGauge setValue:130 animated:YES];
//    self.bigGauge.fillArcFillColor = ANRandomColor;
//    [self.bigGauge setValue:pm2_5 / 3 animated:YES] ;
//    if (pm2_5 <= 50) {
//        self.bigGauge.fillArcFillColor = [UIColor greenColor];
//    } else if (pm2_5 > 50 && pm2_5 <= 100) {
//        self.bigGauge.fillArcFillColor = [UIColor yellowColor];
//    } else if (pm2_5 > 100 && pm2_5 <= 150) {
//        self.bigGauge.fillArcFillColor = ANColor(255, 155, 0, 1);
//    } else if (pm2_5 > 150 && pm2_5 <= 200) {
//        self.bigGauge.fillArcFillColor = ANColor(255, 40, 40, 1);
//    } else if (pm2_5 > 200 && pm2_5 <= 300) {
//        self.bigGauge.fillArcFillColor = ANColor(255, 0, 0, 1);
//    }  else if (pm2_5 > 300) {
//        self.bigGauge.fillArcFillColor = [UIColor purpleColor];
//    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.bigGauge.frame = self.GaugeView.bounds;
}
@end



























