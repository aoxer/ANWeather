//
//  ANRightTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
// 
#import "ANRightTableViewController.h"
#import "ANRightTableViewCell.h"



#import "ANCitySearchController.h"

// 已选城市缓存路径
#define ANSelectedCityFilePath [ANDocumentPath stringByAppendingPathComponent:@"selectedCity.data"]

@interface ANRightTableViewController ()

@end

@implementation ANRightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化tableView
    [self setupTableView];
    
}



- (void)setupTableView
{
    self.tableView.frame = CGRectMake(0, (ANScreenHeight - 54 * 5) /2.0f, ANScreenWidth, 54*5);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.contentInset = UIEdgeInsetsMake(ANScreenHeight*0.5, 0, 0, 0);
    self.tableView.contentSize = CGSizeMake(ANScreenWidth*0.1, ANScreenHeight);
    self.tableView.backgroundColor = ANRandomColor;
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.selectedCitys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    ANRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ANRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
#warning cell向右靠
        // 屏幕适配
        CGFloat indentationLevel = ANScreenWidth / 26;
        cell.indentationLevel = indentationLevel;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        
    }
    
    if (0 == indexPath.row) {
        cell.textLabel.text = @"城市管理";
       
    } else if (1 == indexPath.row){
        
        cell.imageView.image = [UIImage imageNamed:@"addcity"];
        cell.textLabel.text = @"添加城市";
        
        
    } else if (2 == indexPath.row){
        
        cell.imageView.image = [UIImage imageNamed:@"city"];
        cell.textLabel.text = @"定位";
        
    } else {
        
        cell.imageView.image = [UIImage imageNamed:@"city"];
        cell.textLabel.text = self.selectedCitys[indexPath.row];

    }
    
       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (1 == indexPath.row) {
        
        ANCitySearchController *search = [[ANCitySearchController alloc] init];
        [self presentViewController:search animated:YES completion:nil];
        [search returnCityNameBlock:^(NSString *cityName) {


            if(![self.selectedCitys containsObject:cityName]) { // 如果选择城市不存在
                
                // 1.把传回来的城市添加到已选城市列表
                [self.selectedCitys addObject:cityName];
                
                // 2.刷新表格
                [self.tableView reloadData];
                
                // 3.缓存到本地
                [NSKeyedArchiver archiveRootObject:self.selectedCitys toFile:ANSelectedCityFilePath];

            }
            
            
        }];
    
    } else if (2 == indexPath.row){
        
        [ANNotificationCenter postNotificationName:ANGetLocationDidClickNotification object:nil];
    }

}

#pragma mark 懒加载
- (NSMutableArray *)selectedCitys
{
    if (_selectedCitys == nil) {
        
        // 1.从本地读取
        _selectedCitys = [NSKeyedUnarchiver unarchiveObjectWithFile:ANSelectedCityFilePath];
        
        // 2.如果读取出来为空
        if (_selectedCitys == nil) {
            _selectedCitys = [NSMutableArray array];
            [_selectedCitys addObjectsFromArray:@[@"城市管理",@"添加", @"定位"]];
        }
        
    }

    return _selectedCitys;
}




@end
