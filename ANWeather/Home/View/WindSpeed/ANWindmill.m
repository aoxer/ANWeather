//
//  ANWindmill.m
//  ANWeather
//
//  Created by a on 16/1/9.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANWindmill.h"
#import "ANWeatherData.h"


@interface ANWindmill()
/**
 *  扇叶
 */
@property (weak, nonatomic) IBOutlet UIImageView *blade;

/**
 * 风速
 */
@property (assign, nonatomic)CGFloat spd;

@end
@implementation ANWindmill

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANWindmill" owner:nil options:0 ] lastObject];
}

- (void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;
    // 设置风速
    self.spd = weatherData.now.wind.spd.floatValue / 3.6 / 5.f; // /3.6为转换m/s 5.0为系数
    [self rotateWithSpeed];
    
    // 设置显示风向和风速

    
}

- (void)rotateWithSpeed
{
    CGFloat duration = 1.f / self.spd;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.blade.transform = CGAffineTransformRotate(self.blade.transform, M_PI_2);
                     }
                     completion:^(BOOL finished){
                         if (finished) {
                             [self rotateWithSpeed];
                         }
                     }];
    
}

 
@end
