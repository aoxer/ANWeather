//
//  ANPM25ItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANPM25ItemView.h"

@implementation ANPM25ItemView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (void)setCity:(ANCity *)city
{
    _city = city;
    // pm2.5
    self.pm25Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.pm25Label.backgroundColor = ANRandomColor;
    self.pm25Label.text = self.city.pm25;
    [self addSubview:self.pm25Label];
    
    // pm2.5
    self.qltyLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
    self.qltyLabel.backgroundColor = ANRandomColor;
    self.qltyLabel.text = self.city.qlty;
    [self addSubview:self.qltyLabel];

}

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANPM25ItemView" owner:nil options:0 ] lastObject];
}

@end
