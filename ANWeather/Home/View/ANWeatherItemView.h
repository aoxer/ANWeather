//
//  ANWeatherItemView.h
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANWeatherData;
@interface ANWeatherItemView : UIView
/**
 * 天气模型
 */
@property (strong, nonatomic)ANWeatherData *weatherData;
+ (instancetype)view;
@end
