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
    
    self.condLabel.text = weatherData.now.cond.txt;
    self.condImageView.image = [self getWeatherImageWithCondTxt:weatherData.now.cond.txt];
}


/**
 *  根据天气换图片
 */
- (UIImage *)getWeatherImageWithCondTxt:(NSString *)txt
{
    
    
    if ([txt isEqualToString:@"雷阵雨"]) {
        return [UIImage imageNamed:@"thunder_mini"];
        
    }else if ([txt isEqualToString:@"晴"]){
        return [UIImage imageNamed:@"sun_mini"];
        
    }else if ([txt isEqualToString:@"多云"]){
        return [UIImage imageNamed:@"sun_and_cloud_mini"];
        
    }else if ([txt isEqualToString:@"阴"]){
        return [UIImage imageNamed:@"cloud"];
        
    }else if ([txt hasSuffix:@"雨"]){
        return [UIImage imageNamed:@"rain_mini"];
        
    }else if ([txt hasSuffix:@"雪"]){
        return [UIImage imageNamed:@"snow_heavyx_mini"];
        
    }else if ([txt hasSuffix:@"霾"] || [txt hasSuffix:@"雾"]){
        return [UIImage imageNamed:@"sand_float_mini"];
    }else{
        return [UIImage imageNamed:@"sandfloat_mini"];
    }
    
    return [UIImage imageNamed:@"sun"];
    
}

@end
