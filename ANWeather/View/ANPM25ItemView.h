//
//  ANPM25ItemView.h
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANCity.h"
@interface ANPM25ItemView : UIView
/**
 *  pm2.5的label
 */
@property (strong, nonatomic)UILabel *pm25Label;
/**
 *  空气质量的label
 */
@property (strong, nonatomic)UILabel *qltyLabel;

@property (strong, nonatomic)ANCity *city;

+ (instancetype)view;
@end
