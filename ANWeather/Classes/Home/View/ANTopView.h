//
//  ANTopView.h
//  ANWeather
//
//  Created by a on 15/12/31.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArknowM;
@interface ANTopView : UIView

@property (strong, nonatomic)ArknowM *nowm;

 
+ (instancetype)view;
@end
