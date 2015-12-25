//
//  ANTempItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTempItemView.h"

@implementation ANTempItemView

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANTempItemView" owner:nil options:0 ] lastObject];
}
@end
