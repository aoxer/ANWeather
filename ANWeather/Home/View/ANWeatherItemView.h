//
//  ANWeatherItemView.h
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANCondM.h"
@interface ANWeatherItemView : UIView
/**
 *  天气状况
 */
@property (weak, nonatomic) IBOutlet UILabel *condLabel;
/**
 *  天气图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *condImageView;
/**
 *  天气状况
 */
@property (strong, nonatomic)ANCondM *cond;
+ (instancetype)view;
@end
