//
//  ANWindSpeedItemView.h
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArknowM;

@interface ANWindSpeedItemView : UIView

@property (strong, nonatomic)ArknowM *nowm;
+ (instancetype)view;
@end
