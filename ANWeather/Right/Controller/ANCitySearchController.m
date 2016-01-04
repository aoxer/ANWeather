//
//  ANCitySearchController.m
//  ANWeather
//
//  Created by a on 16/1/4.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANCitySearchController.h"

#import "AreaCodeModel.h"
#import "PinYinSortModel.h"


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

- (void)returnCityNameBlock:(cityNameBlock)cityNameBlock
{
    self.cityNameBlock = cityNameBlock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置搜索框
    [self setupSearchController];
    
    // 读取城市们
    [self loadCitys];
   
    
}

- (void)setupSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater =self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.frame = CGRectMake(ANScreenWidth*0.5, -30, 100, 30);
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)loadCitys {

    NSString *citysPath = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"json"];
    NSString *encodingCitys = [NSString stringWithContentsOfFile:citysPath encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [encodingCitys dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
     NSArray *citys = [AreaCodeModel objectArrayWithKeyValuesArray:dict[@"RECORDS"]];
    
    for (AreaCodeModel *model in citys) {

        if (model.City_Name.length && !model.District_Name.length) {
            // 把市级放到数组里
            [self.citysArray addObject:model.City_Name];
        }
    }
    
//    // 创建模型
//    NSMutableArray *pinYinArray = [NSMutableArray array];
//    for (NSString *cityName in self.citysArray) {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchController.active) {
        ANLog(@"active-- %@", self.resultCitys[indexPath.row]);
    } else {
        ANLog(@" %@", self.citysArray[indexPath.row]);

    }
#warning block传值
    if (self.cityNameBlock != nil) {
        if (self.searchController.active) {
            self.cityNameBlock(self.resultCitys[indexPath.row]);
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            self.cityNameBlock(self.citysArray[indexPath.row]);
        }
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 懒加载
- (NSMutableArray *)citysArray
{
    if (_citysArray == nil) {
        _citysArray = [NSMutableArray array];
    }
    return _citysArray;
}

- (NSMutableArray *)resultCitys
{
    if (!_resultCitys) {
        _resultCitys = [NSMutableArray array];
    }
    return _resultCitys;
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
}










@end
