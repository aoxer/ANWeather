//
//  ANDaysWeatherView.m
//  ANWeather
//
//  Created by a on 16/1/10.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANDaysWeatherCell.h"
#import "ANDaysWeatherView.h"
#import "ArknowM.h"
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
 

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self setup];
}

- (void)setup
{
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ANScreenWidth, self.bounds.size.height)];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        self.tableView = tableView;
    }
}

- (void)setNowm:(ArknowM *)nowm
{
    _nowm=nowm;
    
    self.dailyForecastArray = [NSMutableArray arrayWithArray:nowm.daily_forecast];
    // 移除当天数据
    if (self.dailyForecastArray.count) {
        [self.dailyForecastArray removeObjectAtIndex:0];
    }
    [self.tableView reloadData];
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

//szh
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ANDaysWeatherCell *cell = [ANDaysWeatherCell cellWithTableView:tableView];
    cell.nowm = [ArknowM objectWithKeyValues:self.dailyForecastArray[indexPath.row]];
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
