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

#import "ANTodayTomorrowView.h"

#define PhotoFrameMargin 10

@interface ANCareViewController ()
@property (weak, nonatomic) IBOutlet UILabel *city;
// 今天
@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UILabel *todayQlty;
@property (weak, nonatomic) IBOutlet UILabel *todayMin;
@property (weak, nonatomic) IBOutlet UILabel *todayMax;
@property (weak, nonatomic) IBOutlet UILabel *todayCond;
@property (weak, nonatomic) IBOutlet UIImageView *todayIcon;
@property (weak, nonatomic) IBOutlet UILabel *todayWind;

// 明天
@property (weak, nonatomic) IBOutlet UIView *tomorrowView;
 @property (weak, nonatomic) IBOutlet UILabel *tomorrowMin;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowMax;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowCond;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowWind;

@property (weak, nonatomic) IBOutlet UIImageView *photoFrame;

@property (weak, nonatomic) IBOutlet UIView *bigView;


@end

@implementation ANCareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载天气
    [self loadUI];
    
    // 读取天气
    [self loadWeather];
    
}

- (void)loadUI
{
    // 城市
    
    self.photoFrame.layer.shadowColor = [UIColor blackColor].CGColor;
    self.photoFrame.layer.shadowOffset = CGSizeMake(0.5, 1);
    self.photoFrame.layer.shadowOpacity = 0.7;
    
    self.todayView.layer.cornerRadius = ANCornerRadius;
    self.todayView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.tomorrowView.layer.cornerRadius = ANCornerRadius;
    self.tomorrowView.layer.shadowColor = [UIColor blackColor].CGColor;

    

    
    // 今天
//    UIView *today = [self today];
//    today.backgroundColor = ANRandomColor;
//    today.frame = CGRectMake(PhotoFrameMargin*2 ,PhotoFrameMargin*2 , self.photoFrame.width - PhotoFrameMargin*2, (self.photoFrame.height-100)*0.5);
//    [self.photoFrame addSubview:today];
//    
//    // 明天
//    UIView *tomorrow = [self tomorrow];
//    today.backgroundColor = ANRandomColor;
//    today.frame = CGRectMake(PhotoFrameMargin ,today.height , self.photoFrame.width - PhotoFrameMargin*2, (self.photoFrame.height-100)*0.5);
//    [self.photoFrame addSubview:tomorrow];

    
}

- (IBAction)back {
    
     [self.sideMenuViewController presentLeftMenuViewController];
}


- (IBAction)share {
#warning TODO 友盟分享
    UIImage *image = [self ScreenShot];
    
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:ANUMAppKey shareText:@"点击下载"
                                         shareImage:image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToSms,nil]
                                           delegate:nil];
    
    
 
}


/**
 *  读取天气
 */
- (void)loadWeather
{
    NSString *lastCity = [ANOffLineTool getLastCity];
    NSDictionary *weatherDict = [ANOffLineTool weathersWithCity:lastCity];
    
    NSArray *daysWeather = [ANDailyForecastM objectArrayWithKeyValuesArray:weatherDict[@"daily_forecast"]];
    
    // 城市
    self.city.text = lastCity;
    
    // 空气质量
    ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:weatherDict];
    
    // 今明两天
    ANDailyForecastM *today = [daysWeather firstObject];
    ANDailyForecastM *tomorrow = [daysWeather objectAtIndex:1];
    
 
    // 今天
    // 天气
    NSString *txt = nil;
    if (weatherData.now.cond.txt) {
        txt = weatherData.now.cond.txt;
    } else {
        txt = weatherData.now.cond.txt_d;
    }
    self.todayCond.text = txt;
    
    // 最高最低温
    NSString *min = nil;
    NSString *max = nil;
    if ([ANSettingTool isC]) {
        min = [NSString stringWithFormat:@"%@°", today.tmp.min];
        max = [NSString stringWithFormat:@"%@°", today.tmp.max];

    } else {
        min = [NSString stringWithFormat:@"%ld°", ANFahrenheit(today.tmp.min)];
        max = [NSString stringWithFormat:@"%ld°", ANFahrenheit(today.tmp.max)];

     }
    self.todayMax.text = max;
    self.todayMin.text = min;
    
    // 空气质量
    NSString *qlty = weatherData.aqi.city.qlty;
    self.todayQlty.text = qlty;

    // 风
    NSString *dir = weatherData.now.wind.dir;
    NSString *spd = nil;
    if ([ANSettingTool isWindScale]) {
        if ([tomorrow.wind.sc isEqualToString:@"微风"]) {
            spd = [NSString stringWithFormat:@"%@", weatherData.now.wind.sc];
        } else {
            spd = [NSString stringWithFormat:@"%@级", weatherData.now.wind.sc];
        }

    } else {
        spd = [NSString stringWithFormat:@"%@kmh", weatherData.now.wind.spd];
    }
    self.todayWind.text = [NSString stringWithFormat:@"%@ %@", dir, spd];
    
    // 图标
    self.todayIcon.image = [UIImage imageNamed:today.cond.code_d];
    
    // 明天
    // 天气
    NSString *tomoTxt = nil;
    if (tomorrow.cond.txt) {
        tomoTxt = tomorrow.cond.txt;
    } else {
        tomoTxt = tomorrow.cond.txt_d;
    }
    self.tomorrowCond.text = tomoTxt;
    
    // 最高最低温
    NSString *tomoMin = nil;
    NSString *tomoMax = nil;
    if ([ANSettingTool isC]) {
        tomoMin = [NSString stringWithFormat:@"%@°", tomorrow.tmp.min];
        tomoMax = [NSString stringWithFormat:@"%@°", tomorrow.tmp.max];
        
    } else {
        tomoMin = [NSString stringWithFormat:@"%ld°", ANFahrenheit(tomorrow.tmp.min)];
        tomoMax = [NSString stringWithFormat:@"%ld°", ANFahrenheit(tomorrow.tmp.max)];
        
    }
    self.tomorrowMax.text = tomoMax;
    self.tomorrowMin.text = tomoMin;
    
     // 风
    NSString *tomoDir = tomorrow.wind.dir;
    NSString *tomoSpd = nil;
    if ([ANSettingTool isWindScale]) {
        
        if ([tomorrow.wind.sc isEqualToString:@"微风"]) {
            tomoSpd = [NSString stringWithFormat:@"%@", tomorrow.wind.sc];
        } else {
            tomoSpd = [NSString stringWithFormat:@"%@级", tomorrow.wind.sc];
        }
    } else {
        tomoSpd = [NSString stringWithFormat:@"%@kmh", tomorrow.wind.spd];
    }
    self.tomorrowWind.text = [NSString stringWithFormat:@"%@ %@", tomoDir, tomoSpd];
    
    // 图标
    self.tomorrowIcon.image = [UIImage imageNamed:tomorrow.cond.code_d];


    
}

#pragma mark -=====自定义截屏位置大小的逻辑代码=====-
- (UIImage *)ScreenShot{
    
    CGFloat photoFrameW = self.photoFrame.width;
    CGFloat photoFrameH = self.photoFrame.height;
    CGFloat photoFrameX = self.photoFrame.x;
    CGFloat photoFrameY = self.photoFrame.y;
    
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(_bigView.bounds.size, NO, 0.0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 渲染view的图层到上下文
    // 图层只能用渲染不能用draw
    [_bigView.layer renderInContext:ctx];
    
    // 获取截屏图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);
    
    [data writeToFile:@"/Users/a/Desktop/layer.png" atomically:YES];

    
    // 保存图片到照片库
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
//    NSData *imageViewData = UIImagePNGRepresentation(image);
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *pictureName= [NSString stringWithFormat:@"screenShow.png"];
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//    NSLog(@"截屏路径打印: %@", savedImagePath);
//    //这里我将路径设置为一个全局String，这里做的不好，我自己是为了用而已，希望大家别这么写
//    
//    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
    
     return image;
}


/**
 *  动画组 暂时无用
 */
- (void)animLayer:(UIView *)view
{
    
    CABasicAnimation *rotation = [CABasicAnimation animation];
    
    rotation.keyPath = @"transform.rotation";
    
    rotation.toValue = @M_PI_2;
    
    CABasicAnimation *position = [CABasicAnimation animation];
    
    position.keyPath = @"position";
    
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(100, self.view.height-50)];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    
    scale.keyPath = @"transform.scale";
    
    scale.toValue = @0.01;
    
    
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.animations = @[rotation,position,scale];
    
    group.duration = 0.25;
    
    // 取消反弹
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    
    [view.layer addAnimation:group forKey:nil];
}
@end
