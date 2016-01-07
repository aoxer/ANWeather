//
//  ANHumItemView.m
//  ANWeather
//
//  Created by a on 16/1/7.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANHumItemView.h"
#import "ANWeatherData.h"

@interface ANHumItemView ()
@property (weak, nonatomic) IBOutlet UILabel *humLabel;


@end

@implementation ANHumItemView

+ (instancetype)view
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ANHumItemView" owner:nil options:0 ] lastObject];
    
}

-(void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;
    
    self.humLabel.text = [NSString stringWithFormat:@"%@%%", weatherData.now.hum];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
