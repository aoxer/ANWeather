//
//  ANHumidityItemView.h
//  ANWeather
//
//  Created by a on 16/1/19.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANWeatherData;
@interface ANHumidityItemView : UIView

@property (strong, nonatomic)ANWeatherData *weatherData;



+ (instancetype)view;

@end