//
//  ANWindmill.h
//  ANWeather
//
//  Created by a on 16/1/9.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANWeatherData;
@interface ANWindmill : UIView

@property (strong, nonatomic)ANWeatherData *weatherData;

+ (instancetype)view;

@end
