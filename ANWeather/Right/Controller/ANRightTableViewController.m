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
        
        cell.imageView.image = [UIImage imageNamed:@"addcity"];
        cell.textLabel.text = @"添加城市";
        
    } else if (1 == indexPath.row){
        
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
    
    if (0 == indexPath.row) {
        
        ANCitySearchController *search = [[ANCitySearchController alloc] init];
        [self.navigationController presentViewController:search animated:YES completion:nil];
         ANLog(@"presentViewController");
    
    } else if (1 == indexPath.row){
        
        [ANNotificationCenter postNotificationName:ANGetLocationDidClickNotification object:nil];
    }

}

#pragma mark 懒加载
- (NSMutableArray *)selectedCitys
{
    if (_selectedCitys == nil) {
        _selectedCitys = [NSMutableArray array];
        
        for (int i = 0; i<20; i++) {
            [_selectedCitys addObject:[NSString stringWithFormat:@"city%d", i]];
        }
        
        }

    return _selectedCitys;
}




@end
