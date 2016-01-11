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

#import "ANDaysWeatherView.h"

#import "ANTopView.h"

#import "ANWeatherData.h"


#define MARGIN 5
#define ANMaxRow 3
#define ANMaxCol 3


@interface ANWeatherView ()

@property (strong, nonatomic)ANTopView *topView;

@property (strong, nonatomic)NSMutableArray *items;
@property (strong, nonatomic)ANWeatherItemView *weatherItem;
@property (strong, nonatomic)ANWindSpeedItemView *windSpeedItem;
@property (strong, nonatomic)ANPM25ItemView *pm25Item;

@property (strong, nonatomic)ANDaysWeatherView *daysWeatherView;


@end
@implementation ANWeatherView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self weatherView];
        self.backgroundColor = ANColor(100, 100, 100, 0.75);
    }
    return  self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
   
    
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

    // 天气图标
    self.weatherItem.weatherData = weatherData;
    
    // pm2.5
    self.pm25Item.weatherData = weatherData;
    
    // 风速
    self.windSpeedItem.weatherData = weatherData;

    // topView
    self.topView.weatherData = weatherData;
    
    // cell
    self.daysWeatherView.weatherData = weatherData;
    
}

/**
 *  添加方块元素
 */
- (void)weatherView
{
//
//    self.showsVerticalScrollIndicator = NO;
//    // 创建tableView 容纳方块View
//    self.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.backgroundColor = [UIColor redColor];
    
    // 顶部容器
    ANTopView *topView = [ANTopView view];
    [self addSubview:topView];
    self.topView = topView;

    // 湿度
//    ANHumItemView *humItem = [ANHumItemView view];
//    [self addSubview:humItem];
//    self.humItem = humItem;
//    [self.items addObject:humItem];
    
    // 风速
    ANWindSpeedItemView *windSpeedItem = [ANWindSpeedItemView view];
    [self addSubview:windSpeedItem];
    self.windSpeedItem = windSpeedItem;
    [self.items addObject:windSpeedItem];
    
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
    

    // cell
    ANDaysWeatherView *daysWeatherView = [[ANDaysWeatherView alloc] init];
    daysWeatherView.backgroundColor = ANColor(100, 100, 100, 0.5);
    [self addSubview:daysWeatherView];
    self.daysWeatherView = daysWeatherView;
    
    [self.items enumerateObjectsUsingBlock:^(UIView *item, NSUInteger idx, BOOL *stop) {
        item.layer.shadowColor = [UIColor blackColor].CGColor;
        item.layer.shadowOpacity = 1;
        item.layer.shadowRadius = 5;
        item.layer.shadowOffset = CGSizeMake(3, 3);
    }];
 
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
 
    // 布局下面方块元素
    NSInteger count = self.items.count;
    
    
    CGFloat itemViewW = (ANScreenWidth - MARGIN * 4) / ANMaxCol;
    CGFloat itemViewH = (self.height - MARGIN * 4) / ANMaxRow;
    
    for (int i = 0; i<count; i++) {
        
        int row = i / ANMaxCol;
        int col = i % ANMaxCol;
        
        UIView *itemView = self.items[i];
        itemView.backgroundColor = ANColor(200, 200, 200, 0.5);
        CGFloat itemViewX = MARGIN + col * (itemViewW + MARGIN);
        CGFloat itemViewY = self.height - itemViewH - MARGIN - row * (itemViewH + MARGIN);
        itemView.frame = CGRectMake(itemViewX, itemViewY, itemViewW, itemViewH);
    }
    
    // 布局顶部元素
    CGFloat topViewW = ANScreenWidth - MARGIN * 2;
    CGFloat topViewH = self.height - 2 * itemViewH - MARGIN *2;
    CGFloat topViewX = MARGIN;
    CGFloat topViewY = self.height - (itemViewH + MARGIN * 2) - topViewH;
    
    self.topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    self.daysWeatherView.frame = CGRectMake(0, self.height + MARGIN, ANScreenWidth, 44*6);
    
}
//- (UITableView *)tableView
//{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] init];
//    }
//    return _tableView;
//}


@end
