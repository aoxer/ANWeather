//
//  ArkBMKAnnotation.h
//  ANWeather
//
//  Created by 小华 on 2018/9/11.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ArknowM;
@interface ArkBMKAnnotation : NSObject <BMKAnnotation>

@property (nonatomic,strong)ArknowM *nowm;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
