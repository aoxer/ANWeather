//
//  ANSettingTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANSettingTableViewController.h"

@interface ANSettingTableViewController ()
@property (strong, nonatomic)NSMutableArray *titleArray;
@property (strong, nonatomic)NSMutableArray *subTitleArray;
/**
 *  风力是KMH嘛?
 */
@property (assign, nonatomic)BOOL isKMH;
/**
 *  温度是℃嘛?
 */
@property (assign, nonatomic)BOOL isC;
/**
 * 是单手模式嘛?
 */
@property (assign, nonatomic)BOOL isSingleHand;
@end

@implementation ANSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = ANRandomColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];

    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.detailTextLabel.text = self.subTitleArray[indexPath.row];
    
    return cell;
    
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            ANLog(@"%zd", indexPath.row);
            if (self.isKMH) {
                [self.subTitleArray replaceObjectAtIndex:indexPath.row withObject:@"风力等级"];
                self.isKMH = NO;
            } else {
                [self.subTitleArray replaceObjectAtIndex:indexPath.row withObject:@"kmh"];
                self.isKMH = YES;
            }
            
            [self.tableView reloadData];
            break;
            
        case 1:
            
            ANLog(@"%zd", indexPath.row);
            if (self.isC) {
                [self.subTitleArray replaceObjectAtIndex:indexPath.row withObject:@"°F"];
                self.isC = NO;
            } else {
                [self.subTitleArray replaceObjectAtIndex:indexPath.row withObject:@"°C"];
                self.isC = YES;
            }
            
            [self.tableView reloadData];
            break;
            
        case 2:
            
            ANLog(@"%zd", indexPath.row);
            if (self.isSingleHand) {
                [self.subTitleArray replaceObjectAtIndex:indexPath.row withObject:@"单手模式"];
                self.isSingleHand = NO;
            } else {
                [self.subTitleArray replaceObjectAtIndex:indexPath.row withObject:@"双手模式"];
                self.isSingleHand= YES;
            }
            
            [self.tableView reloadData];
            break;
            
        case 3:
            
            ANLog(@"%zd", indexPath.row);
            [self.subTitleArray replaceObjectAtIndex:indexPath.row withObject:@""];
            
            [self.tableView reloadData];
            break;
            
            
        default:
            break;
    }
}


- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"风力单位", @"温度单位",@"单手模式", @"清空缓存", nil];
    }
    return _titleArray;
}

- (NSMutableArray *)subTitleArray
{
    if (!_subTitleArray) {
        _subTitleArray = [NSMutableArray arrayWithObjects:@"风级", @"°C", @"单手", @"缓存大小", nil];
    }
    return _subTitleArray;
}
@end