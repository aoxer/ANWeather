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
 *  空气质量的模型
 */
@property (strong, nonatomic)ANCity *city;
/**
 *  pm2.5的label
 */
@property (weak, nonatomic) IBOutlet UILabel *pm25Label;
/**
 *  pm2.5的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *pm25ImageView;

+ (instancetype)view;

@end
