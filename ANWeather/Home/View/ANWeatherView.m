//
//  ANWeatherView.m
//  ANWeather
//
//  Created by a on 15/12/25.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANWeatherView.h"

#import "ANWeatherItemView.h"
#import "ANWindSpeedItemView.h"
#import "ANPM25ItemView.h"
#import "ANTempItemView.h"

#import "ANDaysWeatherCell.h"

#import "ANTopView.h"

#import "ANWeatherData.h"


#define MARGIN 5
#define ANMaxRow 3
#define ANMaxCol 2


@interface ANWeatherView ()

@property (strong, nonatomic)ANTopView *topView;

@property (strong, nonatomic)NSMutableArray *items;
@property (strong, nonatomic)ANWeatherItemView *weatherItem;
@property (strong, nonatomic)ANWindSpeedItemView *windSpeedItem;
@property (strong, nonatomic)ANPM25ItemView *pm25Item;
@property (strong, nonatomic)ANTempItemView *tempItem;

@property (strong, nonatomic)NSMutableArray *daysWeatherArray;
@property (strong, nonatomic)ANDaysWeatherCell *daysWeatherCell;




@end
@implementation ANWeatherView

/**
 *  懒加载数组
 */
- (NSMutableArray *)daysWeatherArray
{
    if (!_daysWeatherArray) {
        _daysWeatherArray = [NSMutableArray array];
    }
    return _daysWeatherArray;
}

/**
 *  懒加载数组
 */
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;

    // 天气
    self.weatherItem.condLabel.text = weatherData.now.cond.txt;
    self.weatherItem.condImageView.image = [self getWeatherImageWithCondTxt:weatherData.now.cond.txt];
    // pm2.5
    if (weatherData.aqi.city.pm25 == nil) {
        self.pm25Item.pm25Label.text = @"";
    } else {
        self.pm25Item.pm25Label.text = [NSString stringWithFormat:@"PM2.5 %@", weatherData.aqi.city.pm25];
    }
    // 温度
    self.tempItem.tempLabel.text = [NSString stringWithFormat:@"%@°", weatherData.now.tmp];
#warning 字典转模型到底需不需要在这里转
    ANDailyForecastM *day1 = [ANDailyForecastM objectWithKeyValues:[weatherData.daily_forecast firstObject]];
    
   self.tempItem.maxMinTemp.text = [NSString stringWithFormat:@"%@°~%@°", day1.tmp.max, day1.tmp.min];
    
    // 风速
    self.windSpeedItem.windSpeedLabel.text = weatherData.now.wind.sc;
    self.windSpeedItem.windDirLabel.text = weatherData.now.wind.dir;

    
    
}

- (UIImage *)getWeatherImageWithCondTxt:(NSString *)txt
{
    if ([txt isEqualToString:@"雷阵雨"]) {
        return [UIImage imageNamed:@"thunder"];
    }else if ([txt isEqualToString:@"晴"]){
        return [UIImage imageNamed:@"sun"];
    }else if ([txt isEqualToString:@"多云"]){
        return [UIImage imageNamed:@"sunandcloud"];
    }else if ([txt isEqualToString:@"阴"]){
        return [UIImage imageNamed:@"cloud"];
    }else if ([txt hasSuffix:@"雨"]){
        return [UIImage imageNamed:@"rain"];
    }else if ([txt hasSuffix:@"雪"]){
        return [UIImage imageNamed:@"snow"];
    }else{
        return [UIImage imageNamed:@"sandfloat"];
    }
    
    return [UIImage imageNamed:@"sun"];

}

 


/**
 *  添加方块元素
 */
- (void)weatherView
{
    
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = ANColor(40, 40, 40, 1);
    // 创建tableView 容纳方块View
    self.backgroundColor = ANRandomColor;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 顶部容器
    ANTopView *topView = [ANTopView view];
    topView.backgroundColor = ANRandomColor;
    [self addSubview:topView];
    self.topView = topView;

    // 天气
    ANWeatherItemView *weatherItem = [ANWeatherItemView view];
    weatherItem.backgroundColor = ANRandomColor;
    [self addSubview:weatherItem];
    self.weatherItem = weatherItem;
    [self.items addObject:weatherItem];
    
    // pm2.5
    ANPM25ItemView *pm25Item = [ANPM25ItemView view];
    pm25Item.backgroundColor = ANRandomColor;
    [self addSubview:pm25Item];
    self.pm25Item = pm25Item;
    [self.items addObject:pm25Item];
    
    // 温度
    ANTempItemView *tempItem = [ANTempItemView view];
    tempItem.backgroundColor = ANColor(54, 54, 54, 1);
    [self addSubview:tempItem];
    self.tempItem = tempItem;
    [self.items addObject:tempItem];
    
    // 风速
    ANWindSpeedItemView *windSpeedItem = [ANWindSpeedItemView view];
    windSpeedItem.backgroundColor = ANRandomColor;
    [self addSubview:windSpeedItem];
    self.windSpeedItem = windSpeedItem;
    [self.items addObject:windSpeedItem];

   
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 布局下面方块元素
    NSInteger count = self.items.count;
    
    
    CGFloat itemViewW = (ANScreenWidth - MARGIN * 3) / ANMaxCol;
    CGFloat itemViewH = (ANScreenHeight - MARGIN * 3) / ANMaxRow;
    
    for (int i = 0; i<count; i++) {
        
        int row = i / ANMaxCol;
        int col = i % ANMaxCol;
        
        UIView *itemView = self.items[i];
        
        CGFloat itemViewX = MARGIN + col * (itemViewW + MARGIN);
        // y为负值
        CGFloat itemViewY = - ANScreenHeight + (ANScreenHeight - itemViewH * 2 - MARGIN * 2) + row * (itemViewH + MARGIN);
        
        itemView.frame = CGRectMake(itemViewX, itemViewY, itemViewW, itemViewH);
    }
    
    // 布局顶部元素
    CGFloat topViewW = ANScreenWidth;
    CGFloat topViewH = self.height - 2 * itemViewH;
    CGFloat topViewX = 0;
    CGFloat topViewY = -ANScreenHeight + (ANScreenHeight - itemViewH * 2 - MARGIN * 2 - topViewH);
    
    self.topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
}


@end
