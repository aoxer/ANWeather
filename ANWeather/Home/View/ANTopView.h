//
//  ANTopView.h
//  ANWeather
//
//  Created by a on 15/12/31.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ANTopView : UIView
@property (weak, nonatomic) IBOutlet UILabel *currentTmp;
@property (weak, nonatomic) IBOutlet UILabel *minTmp;
@property (weak, nonatomic) IBOutlet UILabel *maxTmp;

@property (weak, nonatomic) IBOutlet UILabel *MonthDay;


+ (instancetype)view;
@end
