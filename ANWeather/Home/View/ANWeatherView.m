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
#import "ANHumItemView.h"

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
@property (strong, nonatomic)ANHumItemView *humItem;

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
    ANLog(@"%s",  __func__);
    _weatherData = weatherData;

    // 天气图标
    self.weatherItem.weatherData = weatherData;
    
    // pm2.5
    self.pm25Item.weatherData = weatherData;
    
    // 温度
    self.humItem.weatherData = weatherData;
    
    // 风速
    self.windSpeedItem.weatherData = weatherData;

    // topView
    self.topView.weatherData = weatherData;
    
    
}

/**
 *  添加方块元素
 */
- (void)weatherView
{
    
    self.showsVerticalScrollIndicator = NO;
    // 创建tableView 容纳方块View
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor lightGrayColor];
    
    // 顶部容器
    ANTopView *topView = [ANTopView view];
    [self addSubview:topView];
    self.topView = topView;

    // 天气
    ANWeatherItemView *weatherItem = [ANWeatherItemView view];
    [self addSubview:weatherItem];
    self.weatherItem = weatherItem;
    [self.items addObject:weatherItem];
    
    // pm2.5
    ANPM25ItemView *pm25Item = [ANPM25ItemView view];
    [self addSubview:pm25Item];
    self.pm25Item = pm25Item;
    [self.items addObject:pm25Item];
    
    // 湿度
    ANHumItemView *humItem = [ANHumItemView view];
    [self addSubview:humItem];
    self.humItem = humItem;
    [self.items addObject:humItem];
    
    // 风速
    ANWindSpeedItemView *windSpeedItem = [ANWindSpeedItemView view];
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
    CGFloat itemViewH = (ANScreenHeight - MARGIN * 3 - 64) / ANMaxRow;
    
    for (int i = 0; i<count; i++) {
        
        int row = i / ANMaxCol;
        int col = i % ANMaxCol;
        
        UIView *itemView = self.items[i];
        itemView.backgroundColor = ANColor(203, 178, 144, 1);
        CGFloat itemViewX = MARGIN + col * (itemViewW + MARGIN);
        // y为负值
        CGFloat itemViewY = - ANScreenHeight + (ANScreenHeight - itemViewH * 2 - MARGIN * 2) + row * (itemViewH + MARGIN);
        
        itemView.frame = CGRectMake(itemViewX, itemViewY, itemViewW, itemViewH);
    }
    
    // 布局顶部元素
    CGFloat topViewW = ANScreenWidth;
    CGFloat topViewH = self.height - 2 * itemViewH;
    CGFloat topViewX = 0;
    CGFloat topViewY = -ANScreenHeight + (ANScreenHeight - itemViewH * 2 - MARGIN * 2 - topViewH) - MARGIN;
    
    self.topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
}


@end
