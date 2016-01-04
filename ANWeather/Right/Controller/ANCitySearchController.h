//
//  ANCitySearchController.h
//  ANWeather
//
//  Created by a on 16/1/4.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cityNameBlock)(NSString *cityName);

@interface ANCitySearchController : UITableViewController

/**
 *  传送城市名的block
 */
@property (copy, nonatomic)cityNameBlock cityNameBlock ;

- (void)returnCityNameBlock:(cityNameBlock)cityNameBlock;

@end
