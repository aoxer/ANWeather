//
//  ANCitySearchController.m
//  ANWeather
//
//  Created by a on 16/1/4.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANCitySearchController.h"

@interface ANCitySearchController ()<UISearchResultsUpdating>

@property (strong, nonatomic)UISearchController *searchController;
/**
 * 存放搜索返回的城市
 */
@property (strong, nonatomic)NSMutableArray *resultCitys;

/**
 *  存放城市们的数组
 */
@property (strong, nonatomic)NSMutableArray *citysArray;
@end

@implementation ANCitySearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater =self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.frame = CGRectMake(ANScreenWidth*0.5, -30, 100, 30);
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.searchController.active ? 1 : self.citysArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchController.active ? self.resultCitys.count : self.citysArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"citys";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.searchController.active) {
        cell.textLabel.text = self.resultCitys[indexPath.row];
    } else {
        cell.textLabel.text = self.citysArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark 懒加载
- (NSMutableArray *)citysArray
{
    if (_citysArray == nil) {
        _citysArray = [NSMutableArray array];
        for (int i = 0; i<21; i++) {
            [_citysArray addObject:[NSString stringWithFormat:@"city-%d", i]];
        }
    }
    return _citysArray;
}

#pragma mark - searchController delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = self.searchController.searchBar.text;
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c]%@", searchString];
    
    if (self.resultCitys != nil) {
        [self.resultCitys removeAllObjects];
    }
    
    // 过滤数据
    self.resultCitys = [NSMutableArray arrayWithArray:[self.citysArray filteredArrayUsingPredicate:preicate]];
    
    // 刷新表格
    [self.tableView reloadData];
    
    ANLog(@"%s",__func__);
}

@end
