//
//  ANTopView.m
//  ANWeather
//
//  Created by a on 15/12/31.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANTopView.h"

@implementation ANTopView

- (void)awakeFromNib
{
    self.backgroundImageView.clipsToBounds = YES;
}
+ (instancetype)view
{

    
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ANTopView" owner:nil options:0] lastObject];
}



@end
