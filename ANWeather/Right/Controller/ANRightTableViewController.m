//
//  ANRightTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
// 
#import "ANRightTableViewController.h"
#import "ANRightTableViewCell.h"
#import "ViewController.h"

#import "MBProgressHUD+MJ.h"

#import "ANCitySearchController.h"

// 已选城市缓存路径
#define ANSelectedCityFilePath [ANDocumentPath stringByAppendingPathComponent:@"selectedCity.data"]


@interface ANRightTableViewController ()<ANRightTableViewCellDelegate>



@end

@implementation ANRightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化tableView
    [self setupTableView];

}


- (void)setupTableView
{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, (ANScreenHeight - 54 * 5) /2.0f, ANScreenWidth, 54*5);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.contentInset = UIEdgeInsetsMake(ANScreenHeight*0.5, 0, 0, 0);
//    self.tableView.contentSize = CGSizeMake(ANScreenWidth*0.1, ANScreenHeight);
    self.tableView.backgroundColor = [UIColor clearColor];

    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 3;
    }
    return self.selectedCitys.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 创建cell
    ANRightTableViewCell *cell = [ANRightTableViewCell cellWithTableView:tableView];
    
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.backgroundColor = [UIColor clearColor];
    switch (indexPath.section) {
        case 0:
        {
            cell.delCityBtn.hidden = YES;
            NSArray *icons = [NSArray arrayWithObjects:@"addCity", @"location", @"", nil];
            NSArray *titles= [NSArray arrayWithObjects:@"添加城市", @"定位", @"", nil];
            cell.locIcon.image = [UIImage imageNamed:icons[indexPath.row]];
            cell.cityName.text = titles[indexPath.row];
            

        }
            break;
            
        case 1:
        {
            cell.locIcon.image = [UIImage imageNamed:@"city"];
            cell.cityName.text = self.selectedCitys[indexPath.row];
         
         }
            break;
            
        default:
            break;
    }
    
    

    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 增加一个空白cell区分上下
    if (indexPath.section == 0 && indexPath.row == 2) {
        return 5;
    }
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0:
            
            if (0 == indexPath.row) {// 添加城市
                
                [self addCity];
                
            } else if (1 == indexPath.row){// 定位
                
                // 回到首页
                ViewController *homeVC = [[ViewController alloc] init];
                self.delegate = homeVC;
                [self.sideMenuViewController toViewController:homeVC];
                
                // 调用代理方法
                if ([self.delegate respondsToSelector:@selector(rightTableViewControllerClickGetLocation)]) {
                    [self.delegate rightTableViewControllerClickGetLocation];
                }

            }
            break;
            
        case 1:
        {
            
            // 回到首页并把城市带过去
            NSString *selectedCity = [self.selectedCitys[indexPath.row] removeShi];
            
            [self.sideMenuViewController backToHomeViewControllerWithSelectedCity:selectedCity];
            
            //点击已选城市把选择城市提到最前
            if (indexPath.row > 2) {
                [self.selectedCitys insertObject:self.selectedCitys[indexPath.row] atIndex:2];
                [self.selectedCitys removeObjectAtIndex:indexPath.row+1];
                
                [self.tableView reloadData];
                
            }
        }
            break;

        default:
            break;
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
            [_selectedCitys addObjectsFromArray:@[@"北京", @"上海", @"深圳", @"广州"]];
        }
        
    }

    return _selectedCitys;
}


#pragma mark ANRightTableViewCellDelegate
/**
 *  删除城市
 */
- (void)rightTableViewCellDidClickDelBtnAtCell:(ANRightTableViewCell *)cell
{
    [self showAlertWithBlock:^{
        [self.selectedCitys removeObjectAtIndex:cell.tag];
        
        // 缓存到本地
        [NSKeyedArchiver archiveRootObject:self.selectedCitys toFile:ANSelectedCityFilePath];
        
        [self.tableView reloadData];
    }];
    

}


/**
 *  弹出提醒设置定位功能
 */
- (void)showAlertWithBlock:(void(^)(void))doSth
{
    
    // 初始化alert控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除这个城市?"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    // cancel
    UIAlertAction  *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                      style:UIAlertActionStyleCancel
                                                    handler:^(UIAlertAction *action) {
                                                        
                                                    }];
    
    // ok
    UIAlertAction  *ok = [UIAlertAction actionWithTitle:@"确定"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    
                                                    doSth();
                                                }];
    
    // 添加动作
    [alert addAction:cancel];
    [alert addAction:ok];
    
    // present出alert
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

/**
 *  添加城市
 */
- (void)addCity
{
    ANCitySearchController *search = [[ANCitySearchController alloc] init];
    
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:search] animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
#pragma mark block
    [search returnCityNameBlock:^(NSString *cityName) {
        
        if(![self.selectedCitys containsObject:cityName]) { // 如果选择城市不存在
            
            // 1.把传回来的城市添加到已选城市列表
            [self.selectedCitys insertObject:cityName atIndex:0];
            
            // 2.刷新表格
            [self.tableView reloadData];
            
            // 3.缓存到本地
            [NSKeyedArchiver archiveRootObject:self.selectedCitys toFile:ANSelectedCityFilePath];
            
        } else { // 如果存在
            
            // 1.提到前面
            NSInteger cityIndex = [self.selectedCitys indexOfObject:cityName];
            [self.selectedCitys removeObjectAtIndex:cityIndex];
            [self.selectedCitys insertObject:cityName atIndex:2];
            
            // 2.刷新表格
            [self.tableView reloadData];
            
            // 3.缓存到本地
            [NSKeyedArchiver archiveRootObject:self.selectedCitys toFile:ANSelectedCityFilePath];
        }
    }];

}


@end
