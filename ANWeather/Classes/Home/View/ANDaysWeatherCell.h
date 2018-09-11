//
//  ANDaysWeatherCell.h
//  ANWeather
//
//  Created by a on 15/12/28.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArknowM;

@interface ANDaysWeatherCell : UITableViewCell

@property (strong, nonatomic)ArknowM *nowm;

/**
 *  根据xib创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
