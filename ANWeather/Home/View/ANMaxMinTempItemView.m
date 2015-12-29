//
//  ANMaxMinTempItemView.m
//  ANWeather
//
//  Created by a on 15/12/28.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANMaxMinTempItemView.h"

@implementation ANMaxMinTempItemView


+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANMaxMinTempItemView" owner:nil options:0] lastObject];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANLog(@"%@", NSStringFromClass([self class]));
}

@end
