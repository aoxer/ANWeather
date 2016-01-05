//
//  ANWindSpeedItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANWindSpeedItemView.h"
#import "ANWeatherData.h"
@interface ANWindSpeedItemView ()
/**
 *  风速
 */
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
/**
 *  风向
 */
@property (weak, nonatomic) IBOutlet UILabel *windDirLabel;

@end
@implementation ANWindSpeedItemView

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANWindSpeedItemView" owner:nil options:0 ] lastObject];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANLog(@"%@", NSStringFromClass([self class]));
}

-(void)setWeatherData:(ANWeatherData *)weatherData
{
    // 风速
    self.windSpeedLabel.text = weatherData.now.wind.sc;
    // 风向
    self.windDirLabel.text = weatherData.now.wind.dir;
}

@end
