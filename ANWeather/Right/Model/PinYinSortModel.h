//
//  PinYinSortModel.h
//  LHand
//
//  Created by ZuoShou on 15/8/5.
//  Copyright (c) 2015年 chenstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaCodeModel.h"

@interface PinYinSortModel : NSObject<NSCoding>
@property (nonatomic, strong) AreaCodeModel *areaCodeModel;

@property (nonatomic, copy) NSString *pinYinFirstLetter;
@end
