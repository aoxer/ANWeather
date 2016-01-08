//
//  ANHumItemView.m
//  ANWeather
//
//  Created by a on 16/1/7.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANHumItemView.h"
#import "ANWeatherData.h"

#import "HumidityView.h"

@interface ANHumItemView ()
@property (weak, nonatomic) IBOutlet UILabel *humLabel;

@property (strong, nonatomic)HumidityView *humidityView;
@end

@implementation ANHumItemView

- (void)drawRect:(CGRect)rect
{
    self.humidityView = [[HumidityView alloc] initWithFrame:self.bounds];
    [self.humidityView buildView];
    [self addSubview:self.humidityView];
}

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
