//
//  ANCareViewController.m
//  ANWeather
//
//  Created by a on 16/1/31.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANCareViewController.h"
#import "ANOffLineTool.h"
#import "ANDailyForecastM.h"
#import "ANAqiM.h"
#import "ANSettingTool.h"
#import "ANWeatherData.h"
#import "UMSocial.h"
#import "UMSocialScreenShoter.h"

@interface ANCareViewController ()

 

@property (weak, nonatomic) IBOutlet UIImageView *top;
@property (weak, nonatomic) IBOutlet UIImageView *bottom;
@property (weak, nonatomic) IBOutlet UITextView *topTextView;
@property (weak, nonatomic) IBOutlet UITextView *bottomTextView;

@end

@implementation ANCareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 禁止编辑
    self.topTextView.editable = NO;
    self.bottomTextView.editable = NO;

//    UIFont *font = [UIFont fontWithName:@"翩翩体-简 常规体" size:33];
//    self.textView.font = font;
    
    // 读取天气
    [self loadWeather];
 
}

- (IBAction)back {
    
     [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)share {
#warning TODO 友盟分享
    
    UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:ANUMAppKey shareText:@"分享文字"
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ, UMShareToInstagram, UMShareToSms, UMShareToTumblr,nil]
                                       delegate:nil];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  读取天气
 */
- (void)loadWeather
{
    NSString *lastCity = [ANOffLineTool getLastCity];
    NSDictionary *weatherDict = [ANOffLineTool weathersWithCity:lastCity];
    
    NSArray *daysWeather = [ANDailyForecastM objectArrayWithKeyValuesArray:weatherDict[@"daily_forecast"]];
    
    // 空气质量
    ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:weatherDict];
    
    // 今明两天
    ANDailyForecastM *today = [daysWeather firstObject];
    ANDailyForecastM *tomorrow = [daysWeather objectAtIndex:1];
    
    
    // 今天
   
    NSString *txt = nil;
    if (weatherData.now.cond.txt) {
        txt = weatherData.now.cond.txt;
    } else {
        txt = weatherData.now.cond.txt_d;
    }
    NSString *min = today.tmp.min;
    NSString *max = today.tmp.max;
    NSString *tmp = nil;
    if ([ANSettingTool isC]) {
        tmp = [NSString stringWithFormat:@"%@~%@°C",min, max];
    } else {
        tmp = [NSString stringWithFormat:@"%@~%@°F",min, max];
    }
    NSString *qlty = weatherData.aqi.city.qlty;
    NSString *dir = weatherData.now.wind.dir;
    NSString *spd = nil;
    if ([ANSettingTool isWindScale]) {
        spd = [NSString stringWithFormat:@"%@级", weatherData.now.wind.sc];
    } else {
        spd = [NSString stringWithFormat:@"%@kmh", weatherData.now.wind.spd];
    }
    
    // 明天
    NSString *txt2moro = nil;
    if (weatherData.now.cond.txt) {
        txt2moro = weatherData.now.cond.txt;
    } else {
        txt2moro = weatherData.now.cond.txt_d;
    }
    
    NSString *min2moro = tomorrow.tmp.min;
    NSString *max2moro = tomorrow.tmp.max;
    NSString *tmp2moro = nil;
    if ([ANSettingTool isC]) {
        tmp2moro = [NSString stringWithFormat:@"%@~%@°C",min2moro, max2moro];
    } else {
        tmp2moro = [NSString stringWithFormat:@"%@~%@°F",min2moro, max2moro];
    }
    NSString *dir2moro = tomorrow.wind.dir;
    NSString *spd2moro = nil;
    if ([ANSettingTool isWindScale]) {
        spd2moro = [NSString stringWithFormat:@"%@级", weatherData.now.wind.sc];
    } else {
        spd2moro = [NSString stringWithFormat:@"%@kmh", weatherData.now.wind.spd];
    }

     
    NSString *topText = [NSString stringWithFormat:@"今天: %@\n %@  \n%@  \n空气质量%@ \n%@%@ ", lastCity, txt, tmp, qlty, dir, spd];
    NSString *bottomText = [NSString stringWithFormat:@"明天: %@ \n%@\n%@%@", txt2moro, tmp2moro, dir2moro, spd2moro];
    
    // 写上去
    self.topTextView.text = topText;
    self.bottomTextView.text = bottomText;

}
 

@end
