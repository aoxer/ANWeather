//
//  ANPM25ItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANPM25ItemView.h"
#import "ANWeatherData.h"


@interface ANPM25ItemView ()

@property (weak, nonatomic) IBOutlet UIView *GaugeView;


/**
 *  pm2.5的label
 */
@property (weak, nonatomic) IBOutlet UILabel *qltyLabel;

@end

@implementation ANPM25ItemView


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    self.bigGauge = [[MSSimpleGauge alloc] initWithFrame:self.GaugeView.bounds];
    ANLog(@"%@\n %@", NSStringFromCGRect(self.GaugeView.frame), NSStringFromCGRect(self.bigGauge.frame));
    self.bigGauge.backgroundColor = ANRandomColor;
    self.bigGauge.startAngle = 0;
    self.bigGauge.endAngle = 180;
    self.bigGauge.value = 20;
    [self addSubview:self.bigGauge];
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
    
    if (weatherData.aqi.city.qlty == nil) {
        self.qltyLabel.text = @"优";
    } else {
        self.qltyLabel.text = weatherData.aqi.city.qlty;
    }
    
}

@end



























