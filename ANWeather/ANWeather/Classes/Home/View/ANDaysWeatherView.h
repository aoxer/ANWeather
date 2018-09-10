//
//  ANDaysWeatherView.h
//  ANWeather
//
//  Created by a on 16/1/10.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANWeatherData;
@interface ANDaysWeatherView : UITableView
@property (strong, nonatomic)ANWeatherData *weatherData;
@end
