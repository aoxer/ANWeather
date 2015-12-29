//
//  ANDaysWeatherCell.h
//  ANWeather
//
//  Created by a on 15/12/28.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANDailyForecastM;

@interface ANDaysWeatherCell : UITableViewCell


@property (strong, nonatomic) ANDailyForecastM *dailyForcast;


/**
 *  根据xib创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
