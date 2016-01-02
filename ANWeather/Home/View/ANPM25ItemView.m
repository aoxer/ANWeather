//
//  ANPM25ItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANPM25ItemView.h"

@implementation ANPM25ItemView

 

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANPM25ItemView" owner:nil options:0 ] lastObject];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANLog(@"%@", NSStringFromClass([self class]));
}

@end
