//
//  ANPM25ItemView.h
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ANWeatherData;

@protocol ANPM25ItemViewDelegate <NSObject>

@optional
- (void)pm25ItemViewDidClick;

@end

@interface ANPM25ItemView : UIView
/**
 *  空气质量的模型
 */
@property (strong, nonatomic)ANWeatherData *weatherData;

@property (weak, nonatomic)id<ANPM25ItemViewDelegate> delegate;
+ (instancetype)view;

@end
