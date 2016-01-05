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


/**
 *  pm2.5的label
 */
@property (weak, nonatomic) IBOutlet UILabel *pm25Label;
/**
 *  pm2.5的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *pm25ImageView;

@end

@implementation ANPM25ItemView

 

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
    if (weatherData.aqi.city.pm25 == nil) {
        self.pm25Label.text = @"";
    } else {
        self.pm25Label.text = [NSString stringWithFormat:@"PM2.5 %@", weatherData.aqi.city.pm25];
    }
}
@end
