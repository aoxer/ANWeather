//
//  ANWindSpeedItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANWindSpeedItemView.h"
#import "ANWindmill.h"
#import "ANWeatherData.h"
@interface ANWindSpeedItemView ()
/**
 *  风速
 */
@property (weak, nonatomic) IBOutlet ANWindmill *windmill;
/**
 *  风向
 */
@property (weak, nonatomic) IBOutlet UILabel *windDirLabel;

@end
@implementation ANWindSpeedItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    ANWindmill *windmill = [ANWindmill view];
    windmill.backgroundColor = [UIColor clearColor];
    windmill.frame = self.windmill.bounds;
    [self addSubview:windmill];
    self.windmill = windmill;
}

 

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANWindSpeedItemView" owner:nil options:0 ] lastObject];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANLog(@"%@", NSStringFromClass([self class]));
}

-(void)setWeatherData:(ANWeatherData *)weatherData
{
    // 风速
    self.windmill.weatherData = weatherData;
    // 风向
    self.windDirLabel.text = [NSString stringWithFormat:@"%@ %@",weatherData.now.wind.dir, weatherData.now.wind.sc];
}


@end
