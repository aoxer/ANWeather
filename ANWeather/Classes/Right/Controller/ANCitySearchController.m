//
//  ANcitiSearchController.m
//  ANWeather
//
//  Created by a on 16/1/4.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANCitySearchController.h"
#import "ViewController.h"
#import "ANAreaM.h"
#import "ANCityM.h"


@interface ANCitySearchController ()<UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic)UISearchController *searchController;
/**
 * 存放搜索返回的城市
 */
@property (strong, nonatomic)NSMutableArray *resultcities;

/**
 *  存放城市们的数组
 */
@property (strong, nonatomic)NSMutableArray *citiesArray;
/**
 *  存放省们的数组
 */
@property (strong, nonatomic)NSMutableArray *areaArray;



@end

@implementation ANCitySearchController

- (void)returnCityNameBlock:(cityNameBlock)cityNameBlock
{
    self.cityNameBlock = cityNameBlock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView
    [self setupTableView];
    
    // 设置搜索框
    [self setupSearchController];
    
    // 读取城市们
    [self loadcities];
   
    
    
}

- (void)setupTableView
{
    
    
    self.tableView.backgroundColor = ANColor(40, 40, 40, 0.1);
    self.navigationItem.title = @"搜索城市";
    self.navigationController.navigationBar.backgroundColor = ANRandomColor;
}

- (void)setupSearchController
{
    self.searchController.searchBar.backgroundColor = ANRandomColor;
    self.searchController.searchBar.placeholder= @"请输入城市中文名";
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater =self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.frame = CGRectMake(ANScreenWidth*0.5, -30, 100, 30);
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)loadcities {

        NSString *citiesPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"];
//    NSString *citiesPath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];

    
    NSString *encodingcities = [NSString stringWithContentsOfFile:citiesPath encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [encodingcities dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
      NSArray *areaes = [ANAreaM objectArrayWithKeyValuesArray:dict[@"area"]];
//
    for (ANAreaM *area in areaes) {
        
        // 把省名提取出来存到areaArray里
        [self.areaArray addObject:area];
        // 把当前省(area)的所有市名提取出来放到array里
        NSArray *areaCityArray = [ANCityM objectArrayWithKeyValuesArray:area.city];
        // 把每个省的市名放到citiesArray里
        for (ANCityM *city in areaCityArray) {
            if (city.city_name.length) {
                 [self.citiesArray addObject:city.city_name];
            }
            
        }
        
    }
    
//    NSArray *cities = [AreaCodeModel objectArrayWithKeyValuesArray:dict[@"RECORDS"]];
//    for (AreaCodeModel *model in cities) {
//
//        if (model.City_Name.length && !model.District_Name.length) {
//            // 把市级放到数组里
//            [self.citiesArray addObject:model.City_Name];
//        }
//    }
    
//    // 创建模型
//    NSMutableArray *pinYinArray = [NSMutableArray array];
//    for (NSString *cityName in self.citiesArray) {
//        PinYinSortModel *py = [[PinYinSortModel alloc] init];
//        py.areaCodeModel.City_Name = cityName;
//        // 传入汉字字符串, 返回大写拼音首字母
//        py.pinYinFirstLetter = [self firstCharactor:cityName];
//        
//        [pinYinArray addObject:py.pinYinFirstLetter];
//    }
//    
//    // 按照拼音首字母分组排序
//    NSMutableArray *sectionHeadName = [NSMutableArray array];
//    
//    // 未分组的排序
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"pinYinFirstLetter" ascending:YES], nil];
//    [pinYinArray sortUsingDescriptors:sortDescriptors];
}

/**
 *  传入汉字字符串, 返回大写拼音首字母
 */
- (NSString *)firstCharactor:(NSString *)string
{
    // 转成可变字符串
    NSMutableString *str = [NSMutableString stringWithString:string];
    // 先转为带声调的拼音, 再转为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    // 转为大写拼音
    NSString *Big = [str capitalizedString];
    
    return [Big substringToIndex:1];
}

#pragma mark - Table view data source & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.searchController.active ? 1 : self.citiesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.active) {
        // 如果有查询结果就有分割线 反之则相反
        if (self.resultcities.count) {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        } else {
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    } else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return self.searchController.active ? self.resultcities.count : self.citiesArray.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cities";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (self.searchController.active) {
        cell.textLabel.text = self.resultcities[indexPath.row];
    } else {
        cell.textLabel.text = self.citiesArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
#warning block传值
    if (self.cityNameBlock != nil) {
        if (self.searchController.active) { // 正在搜索的状态
            
            // 退回键盘
            [self.searchController.searchBar resignFirstResponder];
            
            // 把所选city传给右侧已选城市列表
            self.cityNameBlock(self.resultcities[indexPath.row]);
            
            // 拿到所选城市
            NSString *selectedCity = [self.resultcities[indexPath.row] removeShi];
            
            // 回到首页并把城市带过去
            [self.sideMenuViewController backToHomeViewControllerWithSelectedCity:selectedCity];
            

        } else { // 直接选择城市的状态
            
            // 把所选city传给右侧已选城市列表
            self.cityNameBlock(self.citiesArray[indexPath.row]);
            
            // 拿到所选城市
            NSString *selectedCity = [self.citiesArray[indexPath.row] removeShi];
           
            // 回到首页并把城市带过去
            [self.sideMenuViewController backToHomeViewControllerWithSelectedCity:selectedCity];
        }
    }
   
}


#pragma mark 懒加载
- (NSMutableArray *)areaArray
{
    if (_areaArray == nil) {
        _areaArray = [NSMutableArray array];
    }
    return _areaArray;
}

- (NSMutableArray *)citiesArray
{
    if (_citiesArray == nil) {
        _citiesArray = [NSMutableArray array];
    }
    return _citiesArray;
}

- (NSMutableArray *)resultcities
{
    if (!_resultcities) {
        _resultcities = [NSMutableArray array];
    }
    return _resultcities;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - searchController delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = self.searchController.searchBar.text;
    
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c]%@", searchString];
    
    if (self.resultcities != nil) {
        [self.resultcities removeAllObjects];
    }

    // 过滤数据
    self.resultcities = [NSMutableArray arrayWithArray:[self.citiesArray filteredArrayUsingPredicate:preicate]];
    
    // 刷新表格
    [self.tableView reloadData];
}

#pragma UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
      self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return YES;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.searchController.active) {
        [self.searchController.view endEditing:YES];
    }

}





@end
