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
#import "ANHumidityItemView.h"
#import "ANDaysWeatherView.h"

#import "ANTopView.h"

#import "ANWeatherData.h"



#define ANMaxRow 3
#define ANMaxCol 3


@interface ANWeatherView () <ANPM25ItemViewDelegate>

@property (weak, nonatomic)ANTopView *topView;

@property (strong, nonatomic)NSMutableArray *items;
@property (weak, nonatomic)ANWeatherItemView *weatherItem;
@property (weak, nonatomic)ANWindSpeedItemView *windSpeedItem;
@property (weak, nonatomic)ANPM25ItemView *pm25Item;
@property (weak, nonatomic)ANHumidityItemView *humItem;

@property (weak, nonatomic)ANDaysWeatherView *daysWeatherView;
 

@end
@implementation ANWeatherView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self weatherView];
        self.backgroundColor = ANClearColor;
       
    }
    return  self;
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
     


    [UIView transitionWithView:self.topView duration:0.25 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        
    } completion:^(BOOL finished) {
        [UIView transitionWithView:self.windSpeedItem duration:0.25 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
        } completion:^(BOOL finished) {
            [UIView transitionWithView:self.weatherItem duration:0.25 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                
            } completion:^(BOOL finished) {
                [UIView transitionWithView:self.pm25Item duration:0.25 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                    
                } completion:^(BOOL finished) {
                    //
                }];
                
            }];
            
        }];
        
    }];
    
// GCD
    
//    [self subView:self.topView animWithType:@"pageu"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self subView:self.windSpeedItem animWithType:@"cube"];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self subView:self.weatherItem animWithType:@"cube"];
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self subView:self.pm25Item animWithType:@"cube"];
//    });
}

/**
 *  添加方块元素
 */
- (void)weatherView
{
    // 顶部容器
    ANTopView *topView = [ANTopView view];
    [self addSubview:topView];
    self.topView = topView;
    
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
    
//    // 湿度
//    ANHumidityItemView *humItem = [ANHumidityItemView view];
//    [self addSubview:humItem];
//    self.humItem = humItem;
//    [self.items addObject:humItem];

    
    // cell
    ANDaysWeatherView *daysWeatherView = [[ANDaysWeatherView alloc] init];
    daysWeatherView.backgroundColor = ANColor(100, 100, 100, 0.5);
    [self addSubview:daysWeatherView];
    self.daysWeatherView = daysWeatherView;
    
 
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
        
        // 设置layer
//        itemView.layer.backgroundColor = ANLayerBackgroundColor;
        itemView.layer.cornerRadius = ANCornerRadius;
        
        CGFloat itemViewX = MARGIN + col * (itemViewW + MARGIN);
        CGFloat itemViewY = self.height - itemViewH - MARGIN - row * (itemViewH + MARGIN);
        itemView.frame = CGRectMake(itemViewX, itemViewY, itemViewW, itemViewH);
    }
    
    // 布局顶部元素
    CGFloat topViewW = ANScreenWidth - MARGIN * 2;
    CGFloat topViewH = itemViewH ;
    CGFloat topViewX = MARGIN;
    CGFloat topViewY = self.height - (itemViewH + MARGIN * 2) - topViewH;
    
    // topView
    self.topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);



    // 一周天气
    self.daysWeatherView.frame = CGRectMake(MARGIN, self.height , ANScreenWidth - MARGIN * 2, 44*6);
    // 设置layer
    self.daysWeatherView.layer.backgroundColor = ANLayerBackgroundColor;
    self.daysWeatherView.layer.cornerRadius = ANCornerRadius;
    

    
}

#pragma mark   ANPM25ItemViewDelegate
- (void)pm25ItemViewDidClick
{
    
    
    
//    [self.items replaceObjectAtIndex:<#(NSUInteger)#> withObject:<#(id)#>]
}

@end
