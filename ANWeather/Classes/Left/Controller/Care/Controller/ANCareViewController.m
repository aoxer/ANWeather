//
//  ANCareViewController.m
//  ANWeather
//
//  Created by a on 16/1/31.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANCareViewController.h"
#import "ANOffLineTool.h"
#import "ANSettingTool.h"
#import "UMSocial.h"
#import "ArknowM.h"

#define PhotoFrameMargin 10
#define ANSelectedCityFilePath [ANDocumentPath stringByAppendingPathComponent:@"selectedCity.data"]

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
    CGFloat screenHeight = ANScreenHeight;

    if (screenHeight == 667) {
        self.todaytmp.font = [UIFont fontWithName:@"Verdana-Bold" size:30];
        self.todayCond.font = [UIFont systemFontOfSize:17];
        self.todayQlty.font = [UIFont systemFontOfSize:17];

        self.tomorrowtmp.font = [UIFont fontWithName:@"Verdana-Bold" size:30];
        self.tomorrowCond.font = [UIFont systemFontOfSize:17];
        self.tomorrowWind.font = [UIFont systemFontOfSize:17];

    } else if (screenHeight == 736) {
        
        self.todaytmp.font = [UIFont fontWithName:@"Verdana-Bold" size:40];
        self.todayCond.font = [UIFont systemFontOfSize:20];
        self.todayQlty.font = [UIFont systemFontOfSize:20];
        
        self.tomorrowtmp.font = [UIFont fontWithName:@"Verdana-Bold" size:40];
        self.tomorrowCond.font = [UIFont systemFontOfSize:20];
        self.tomorrowWind.font = [UIFont systemFontOfSize:20];

    } else if (screenHeight == 480) {
        
        self.todaytmp.font = [UIFont fontWithName:@"Verdana-Bold" size:20];
        self.todayCond.font = [UIFont systemFontOfSize:10];
        self.todayQlty.font = [UIFont systemFontOfSize:10];
        
        self.tomorrowtmp.font = [UIFont fontWithName:@"Verdana-Bold" size:20];
        self.tomorrowCond.font = [UIFont systemFontOfSize:10];
        self.tomorrowWind.font = [UIFont systemFontOfSize:10];
        
    }

    
    
    
    // 相框阴影
    self.photoFrame.layer.shadowOffset = CGSizeMake(2, 5);
    self.photoFrame.layer.shadowOpacity = 0.15;
    self.photoFrame.layer.shadowRadius = 4;
    
    // 今天
    self.todayView.layer.shadowOffset = CGSizeMake(2,5);
    self.todayView.layer.shadowOpacity = 0.1;
    self.todayView.layer.shadowRadius = 4;
    for (UIView *view in [self.todayView subviews]) {
        view.layer.shadowOffset = CGSizeMake(10,10);
        view.layer.shadowOpacity = 0.15;
        view.layer.shadowRadius = 4;
    }
    self.todayView.layer.cornerRadius = ANCornerRadius;

    // 明天
    self.tomorrowView.layer.shadowOffset = CGSizeMake(2,5);
    self.tomorrowView.layer.shadowOpacity = 0.15;
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
 
    [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:ANUMAppKey shareText:@"注意天气哦!"
                                         shareImage:image
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina ,UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToSms, UMShareToEmail, UMShareToFacebook, UMShareToInstagram, UMShareToTwitter, nil]
                                           delegate:nil];
    
    
 
}


/**
 *  读取天气
 */

//szh
- (void)loadWeather
{
    
    NSString *CurrentCityPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"current.city"];
    ANLog(@"%@", CurrentCityPath);
    NSString *currentCity = [ANOffLineTool getCurrentCity];//[NSKeyedUnarchiver unarchiveObjectWithFile:CurrentCityPath];
    
    NSDictionary *weatherDict = [ANOffLineTool weathersWithCity:currentCity];
    
    NSArray *daysWeather = [ArknowM objectArrayWithKeyValuesArray:weatherDict[@"daily_forecast"]];
    
    // 城市
    self.city.text = currentCity;
    
    // 今明两天
    ArknowM *today = [daysWeather firstObject];
    ArknowM *tomorrow = [daysWeather objectAtIndex:1];
    
    // 今天日期
    self.shareDate.text = [self dateWithMonthDay:today.date];
    
    // 今天
    // 天气天气文字

    self.todayCond.text = today.cond_txt_d;
    
    // 最高最低温
    NSString *min = nil;
    NSString *max = nil;
    if ([ANSettingTool isC]) {
        min = [NSString stringWithFormat:@"%@", today.tmp_min];
        max = [NSString stringWithFormat:@"%@", today.tmp_max];

    } else {
        min = [NSString stringWithFormat:@"%ld", ANFahrenheit(today.tmp_min)];
        max = [NSString stringWithFormat:@"%ld", ANFahrenheit(today.tmp_max)];

     }
    
    NSString *tmp = [NSString stringWithFormat:@"%@~%@°", min, max];
    self.todaytmp.text = tmp;
    
 
    


    // 风
    NSString *spd = nil;
    if ([ANSettingTool isWindScale]) {
        if ([today.wind_sc isEqualToString:@"微风"]) {
            spd = [NSString stringWithFormat:@"%@", today.wind_sc];
        } else {
            spd = [NSString stringWithFormat:@"%@级",today.wind_sc];
        }

    } else {
        spd = [NSString stringWithFormat:@"%@kmh", today.wind_spd];
    }
    
    // 数据没有了,改成风
    self.todayQlty.text = [NSString stringWithFormat:@"%@%@", today.wind_dir, spd];

    // 图标
    self.todayIcon.image = [self ImageWithCondTxt:today.cond_txt_d];
    
    // 明天
    // 天气

    self.tomorrowCond.text = tomorrow.cond_txt_d;
    
    // 最高最低温
    NSString *tomoMin = nil;
    NSString *tomoMax = nil;
    if ([ANSettingTool isC]) {
        tomoMin = [NSString stringWithFormat:@"%@", tomorrow.tmp_min];
        tomoMax = [NSString stringWithFormat:@"%@", tomorrow.tmp_max];
        
    } else {
        tomoMin = [NSString stringWithFormat:@"%ld", ANFahrenheit(tomorrow.tmp_min)];
        tomoMax = [NSString stringWithFormat:@"%ld", ANFahrenheit(tomorrow.tmp_max)];
        
    }
    
    NSString *tomoTmp = [NSString stringWithFormat:@"%@~%@°", tomoMin, tomoMax];
    self.tomorrowtmp.text = tomoTmp;
    
     // 风

    NSString *tomoSpd = nil;
    if ([ANSettingTool isWindScale]) {
        
        if ([tomorrow.wind_sc isEqualToString:@"微风"]) {
            tomoSpd = [NSString stringWithFormat:@"%@", tomorrow.wind_sc];
        } else {
            tomoSpd = [NSString stringWithFormat:@"%@级", tomorrow.wind_sc];
        }
    } else {
        tomoSpd = [NSString stringWithFormat:@"%@kmh", tomorrow.wind_spd];
    }
    self.tomorrowWind.text = [NSString stringWithFormat:@"%@%@", tomorrow.wind_dir, tomoSpd];
    
    // 图标
    self.tomorrowIcon.image = [self ImageWithCondTxt:tomorrow.cond_txt_d];

    
}


- (UIImage *)ImageWithCondTxt:(NSString *)CondTxt
{
    
    
    UIImage *image = [UIImage imageNamed:@"share_sun"];
    if ([CondTxt isEqualToString:@"晴"]) {
        image = [UIImage imageNamed:@"share_sun"];
        
        return image;
    } else if ([CondTxt hasSuffix:@"雨"]){
        
        image = [UIImage imageNamed:@"share_rain"];
        return image;
    } else if ([CondTxt hasSuffix:@"阴"]){
        
        image = [UIImage imageNamed:@"share_overcast"];
        return image;
    } else if ([CondTxt hasSuffix:@"云"]){
        
        image = [UIImage imageNamed:@"share_cloudy"];
        
        return image;
    } else if ([CondTxt hasSuffix:@"雪"]){
        
        image = [UIImage imageNamed:@"share_snow"];
        
        
        return image;
    } else if ([CondTxt hasSuffix:@"雾"]){
        
        image = [UIImage imageNamed:@"share_foggy"];
        
        
        return image;
    } else if ([CondTxt hasSuffix:@"霾"]){
        
        image = [UIImage imageNamed:@"share_haze"];
        
        
        return image;
    }
    
    
    return image;
}

#pragma mark -=====自定义截屏位置大小的逻辑代码=====-
- (UIImage *)ScreenShot{
     
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
