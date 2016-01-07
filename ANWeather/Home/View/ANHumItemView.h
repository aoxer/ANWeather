//
//  ANHumItemView.h
//  ANWeather
//
//  Created by a on 16/1/7.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANWeatherData;
@interface ANHumItemView : UIView
/**
 *  天气模型
 */
@property (strong, nonatomic)ANWeatherData *weatherData;

+ (instancetype)view;
@end
