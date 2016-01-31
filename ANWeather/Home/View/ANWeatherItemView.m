//
//  ANWeatherItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANWeatherItemView.h"
#import "ANWeatherData.h"

@interface ANWeatherItemView ()

/**
 *  天气状况
 */
@property (weak, nonatomic) IBOutlet UILabel *condLabel;
/**
 *  天气图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *condImageView;


@end

@implementation ANWeatherItemView

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
   
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.cornerRadius = ANCornerRadius;
    gradient.shadowColor = [UIColor blackColor].CGColor;
    gradient.shadowOffset = CGSizeMake(1.5, 1.5);
    gradient.shadowOpacity = 0.5;


    gradient.frame = rect;
    gradient.colors = [NSArray arrayWithObjects:(id)ANColor(255, 255, 255, 0.1).CGColor,
                       (id)ANItemBackgroundColor, nil];
    [self.layer insertSublayer:gradient atIndex:0];
    
}

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANWeatherItemView" owner:nil options:0 ] lastObject];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    ANLog(@"%@", NSStringFromClass([self class]));
}

- (void)setWeatherData:(ANWeatherData *)weatherData
{
    self.condLabel.font = ANLightFontSize17;
    self.condLabel.text = weatherData.now.cond.txt;
    self.condImageView.image = [self getWeatherImageWithCondCode:weatherData.now.cond.code];
}


/**
 *  根据天气换图片
 */
- (UIImage *)getWeatherImageWithCondCode:(NSString *)code
{
    return [UIImage imageNamed:code];
    
}

@end
