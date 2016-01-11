//
//  ANDaysWeatherView.m
//  ANWeather
//
//  Created by a on 16/1/10.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANDaysWeatherCell.h"
#import "ANDaysWeatherView.h"
#import "ANWeatherData.h"

@interface ANDaysWeatherView () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic)UITableView *tableView;

@property (strong, nonatomic)ANDaysWeatherCell *daysWeatherCell;

/**
 *  几日天气模型数组
 */
@property (strong, nonatomic)NSMutableArray *dailyForecastArray;

@end
@implementation ANDaysWeatherView



- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ANScreenWidth, self.bounds.size.height)];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
}



- (void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;
    self.dailyForecastArray = [ANDailyForecastM objectArrayWithKeyValuesArray:weatherData.daily_forecast];
    
}



#pragma mark  UITableViewDataSource & UITableViewDelete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dailyForecastArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANDaysWeatherCell *cell = [ANDaysWeatherCell cellWithTableView:tableView];
    
    cell.dailyForcast = self.dailyForecastArray[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

#pragma mark 懒加载们
- (NSMutableArray *)dailyForecastArray
{
    if (!_dailyForecastArray) {
        _dailyForecastArray = [NSMutableArray array];
    }
    return _dailyForecastArray;
}
@end