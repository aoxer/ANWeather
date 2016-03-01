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
 
#import "ANTodayTomorrowView.h"

#define PhotoFrameMargin 10

@interface ANCareViewController ()
@property (weak, nonatomic) IBOutlet UILabel *city;
// 今天
@property (weak, nonatomic) IBOutlet UIView *todayView;
@property (weak, nonatomic) IBOutlet UILabel *todayQlty;
@property (weak, nonatomic) IBOutlet UILabel *todaytmp;
@property (weak, nonatomic) IBOutlet UILabel *todayCond;
@property (weak, nonatomic) IBOutlet UIImageView *todayIcon;
@property (weak, nonatomic) IBOutlet UILabel *todayIsC;

// 明天
@property (weak, nonatomic) IBOutlet UIView *tomorrowView;
 @property (weak, nonatomic) IBOutlet UILabel *tomorrowtmp;
 @property (weak, nonatomic) IBOutlet UILabel *tomorrowCond;
@property (weak, nonatomic) IBOutlet UIImageView *tomorrowIcon;
@property (weak, nonatomic) IBOutlet UILabel *tomorrowWind;

@property (weak, nonatomic) IBOutlet UIImageView *photoFrame;

@property (weak, nonatomic) IBOutlet UIView *bigView;

@property (weak, nonatomic) IBOutlet UILabel *shareDate;
@property (weak, nonatomic) IBOutlet UILabel *tomoIsC;

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
    
    // 相框阴影
    self.photoFrame.layer.shadowOffset = CGSizeMake(2, 5);
    self.photoFrame.layer.shadowOpacity = 0.1;
    self.photoFrame.layer.shadowRadius = 4;
    
    // 今天
    self.todayView.layer.shadowOffset = CGSizeMake(2,5);
    self.todayView.layer.shadowOpacity = 0.11;
    self.todayView.layer.shadowRadius = 4;
    for (UIView *view in [self.todayView subviews]) {
        view.layer.shadowOffset = CGSizeMake(10,10);
        view.layer.shadowOpacity = 0.11;
        view.layer.shadowRadius = 4;
    }
    self.todayView.layer.cornerRadius = ANCornerRadius;

    // 明天
    self.tomorrowView.layer.shadowOffset = CGSizeMake(2,5);
    self.tomorrowView.layer.shadowOpacity = 0.11;
    self.tomorrowView.layer.shadowRadius = 4;
    for (UIView *view in [self.tomorrowView subviews]) {
    view.layer.shadowOffset = CGSizeMake(10,10);
    view.layer.shadowOpacity = 0.11;
    view.layer.shadowRadius = 4;
}
     self.tomorrowView.layer.cornerRadius = ANCornerRadius;
 
    

    
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
    
    // 以图片形式分享
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
 
    
    UIImage *image = [self ScreenShot];
    ANLog(@"clickShare");
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:ANUMAppKey shareText:@"注意天气哦!"
                                         shareImage:image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina ,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToSms, UMShareToEmail, UMShareToFacebook, UMShareToInstagram, UMShareToTwitter, nil]
                                           delegate:nil];
    
    
 
}


/**
 *  读取天气
 */
- (void)loadWeather
{
    NSString *currentCity = [ANOffLineTool getCurrentCity];
    
    NSDictionary *weatherDict = [ANOffLineTool weathersWithCity:currentCity];
    
    NSArray *daysWeather = [ANDailyForecastM objectArrayWithKeyValuesArray:weatherDict[@"daily_forecast"]];
    
    // 城市
    self.city.text = currentCity;
    
   
    
    // 空气质量
    ANWeatherData *weatherData = [ANWeatherData objectWithKeyValues:weatherDict];
    
    // 今明两天
    ANDailyForecastM *today = [daysWeather firstObject];
    ANDailyForecastM *tomorrow = [daysWeather objectAtIndex:1];
    
    // 今天日期
    self.shareDate.text = [self dateWithMonthDay:today.date];
    
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
        min = [NSString stringWithFormat:@"%@", today.tmp.min];
        max = [NSString stringWithFormat:@"%@°", today.tmp.max];

    } else {
        min = [NSString stringWithFormat:@"%ld", ANFahrenheit(today.tmp.min)];
        max = [NSString stringWithFormat:@"%ld°", ANFahrenheit(today.tmp.max)];

     }
    
    NSString *tmp = [NSString stringWithFormat:@"%@~%@", min, max];
    self.todaytmp.text = tmp;
    
 
    
    // 空气质量
    NSString *qlty = weatherData.aqi.city.qlty;
    self.todayQlty.text = qlty;

    // 风
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
//    self.todayWind.text = [NSString stringWithFormat:@"%@ %@", dir, spd];
    
    // 图标
    self.todayIcon.image = [self ImageWithWeather:weatherData];
    
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
        tomoMin = [NSString stringWithFormat:@"%@", tomorrow.tmp.min];
        tomoMax = [NSString stringWithFormat:@"%@°", tomorrow.tmp.max];
        
    } else {
        tomoMin = [NSString stringWithFormat:@"%ld", ANFahrenheit(tomorrow.tmp.min)];
        tomoMax = [NSString stringWithFormat:@"%ld°", ANFahrenheit(tomorrow.tmp.max)];
        
    }
    
    NSString *tomoTmp = [NSString stringWithFormat:@"%@~%@", tomoMin, tomoMax];
    self.tomorrowtmp.text = tomoTmp;
    
     // 风
    NSString *tomoDir = tomorrow.wind.dir;
    if ([tomoDir isEqualToString:@"无持续风向"]) {
        tomoDir = @"";
    } else {
        tomoDir = [NSString stringWithFormat:@"%@ ", tomorrow.wind.dir];
    }
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
    self.tomorrowWind.text = [NSString stringWithFormat:@"%@%@", tomoDir, tomoSpd];
    
    // 图标
    self.tomorrowIcon.image = [self ImageWithWeather:weatherData];


    
}

- (UIImage *)ImageWithWeather:(ANWeatherData *)weatherData
{
    NSString *txt = nil;
    if (weatherData.now.cond.txt) {
        txt = weatherData.now.cond.txt;
    } else {
        txt = weatherData.now.cond.txt_d;
    }
    
    UIImage *image = [UIImage imageNamed:@"share_sun"];
    if ([txt isEqualToString:@"晴"]) {
        image = [UIImage imageNamed:@"share_sun"];
        
        return image;
    } else if ([txt hasSuffix:@"雨"]){
        
        image = [UIImage imageNamed:@"share_rain"];
        return image;
    } else if ([txt hasSuffix:@"阴"]){
        
        image = [UIImage imageNamed:@"share_yintian"];
        return image;
    } else if ([txt hasSuffix:@"云"]){
        
        image = [UIImage imageNamed:@"share_cloudy"];
        
        return image;
    } else if ([txt hasSuffix:@"雪"]){
        
        image = [UIImage imageNamed:@"share_snow"];
        
        
        return image;
    } else if ([txt hasSuffix:@"雾"]){
        
        image = [UIImage imageNamed:@"share_foggy"];
        
        
        return image;
    } else if ([txt hasSuffix:@"霾"]){
        
        image = [UIImage imageNamed:@"share_haze"];
        
        
        return image;
    }
    
    
    return image;
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
 *  把日期转为月日
 */
- (NSString *)dateWithMonthDay:(NSString *)date
{
    
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [date substringWithRange:NSMakeRange(8, 2)];
    NSString *MMDD = [NSString stringWithFormat:@"%@.%@", month, day];
    
    return MMDD;
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
