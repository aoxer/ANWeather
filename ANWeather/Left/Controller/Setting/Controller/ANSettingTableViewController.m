//
//  ANSettingTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANSettingTableViewController.h"
#import "MBProgressHUD+MJ.h"


@interface ANSettingTableViewController ()
/**
 *  风力是KMH嘛?
 */
@property (assign, nonatomic)BOOL isKMH;
/**
 *  温度是℃嘛?
 */
@property (assign, nonatomic)BOOL isC;
/**
 * 是大手模式嘛?
 */
@property (assign, nonatomic)BOOL isBigHand;
/**
 * 缓存大小
 */
@property (copy, nonatomic)NSString *cache;
/**
 * 大小手模式
 */
@property (copy, nonatomic)NSString *bigSmallHand;
/**
 * 风力单位
 */
@property (copy, nonatomic)NSString *windSpeedMode;
/**
 * 温度单位
 */
@property (copy, nonatomic)NSString *tmpMode;




@end

@implementation ANSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = ANColor(217, 217, 223, 1.0);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self.sideMenuViewController Action:@selector(presentLeftMenuViewController) andImageName:@"back" andImageNameHighlight:@"back"];
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];

    }
    
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    switch (indexPath.section) {
        case 0:
            indexPath.row == 0 ? (cell.textLabel.text = @"温度单位") : (cell.textLabel.text = @"风力单位");
            indexPath.row == 0 ? (cell.detailTextLabel.text = self.tmpMode) : (cell.detailTextLabel.text = self.windSpeedMode);
            cell.imageView.image = [UIImage imageNamed:@[@"blueArrow", @"blueArrow"][indexPath.row]];
            break;
            
        case 1:
            cell.textLabel.text = @"大手模式";
            cell.detailTextLabel.text = self.bigSmallHand;
            cell.imageView.image = [UIImage imageNamed:@"blueArrow"];
            break;
            
        case 2:
            cell.textLabel.text = @"清空缓存";
             cell.detailTextLabel.text = [self getCacheSize];
            cell.imageView.image = [UIImage imageNamed:@"blueArrow"];
            break;
            
        case 3:
            
            cell.textLabel.text = @"摇一摇分享";
            [self switchBtnAtCell:cell];
            cell.highlighted = NO;
            cell.imageView.image = [UIImage imageNamed:@"blueArrow"];
            break;
        default:
            break;
    }
    return cell;
    
}

- (void)switchBtnAtCell:(UITableViewCell *)cell
{
    UISwitch *switchBtn = [[UISwitch alloc] init];
    switchBtn.centerY = cell.centerY;
    switchBtn.x = cell.width - switchBtn.width - 20;
    [cell.contentView addSubview:switchBtn];
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    
                    self.isC ? (self.tmpMode = @"°F") : (self.tmpMode = @"°C");
                    self.isC = !self.isC;

                    break;
                    
                case 1:
                    
                    self.isKMH ? (self.windSpeedMode = @"风力级数") : (self.windSpeedMode = @"km/h");
                    self.isKMH = !self.isKMH;

                    break;
                    
                default:
                    break;
            }
            
            break;
            
        case 1:
            
            self.isBigHand ? (self.bigSmallHand = @"小手模式") : (self.bigSmallHand = @"大手模式");
            self.isBigHand = !self.isBigHand;
             break;
            
        case 2:
            // 清空缓存
            
            [MBProgressHUD showMessage:@"正在清理..." toView:self.view];
            [self myClearCacheAction];
            self.cache = [self getCacheSize];
             break;
            
        default:
            break;
            
    }
    [self.tableView reloadData];
}



#pragma mark - 计算缓存大小
- (NSString *)getCacheSize
{
   //定义变量存储总的缓存大小
   long long sumSize = 0;

   //01.获取当前图片缓存路径
   NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];

    //02.创建文件管理对象
    NSFileManager *filemanager = [NSFileManager defaultManager];

        //获取当前缓存路径下的所有子路径
    NSArray *subPaths = [filemanager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
   
        //遍历所有子文件
    for (NSString *subPath in subPaths) {
             //1）.拼接完整路径
         NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
             //2）.计算文件的大小
         long long fileSize = [[filemanager attributesOfItemAtPath:filePath error:nil]fileSize];
             //3）.加载到文件的大小
         sumSize += fileSize;
     }
    
     float size_m = sumSize/(1024*1024);
     return [NSString stringWithFormat:@"%.2fM",size_m];
    
}

-(void)myClearCacheAction{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%lu",(unsigned long)[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                               
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
    
}


-(void)clearCacheSuccess
{
    
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:@"清理成功"];
    
}

- (NSString *)windSpeedMode
{
    if (!_windSpeedMode) {
        _windSpeedMode = @"风力级数";
    }
    return _windSpeedMode;
}

- (NSString *)tmpMode
{
    if (!_tmpMode) {
        _tmpMode = @"°C";
    }
    return _tmpMode;
}

- (NSString *)bigSmallHand
{
    if (!_bigSmallHand) {
        _bigSmallHand = @"大手模式";
    }
    return _bigSmallHand;
}
//
//
//- (void)getCacheSize{
//    
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//        
//        CGFloat fileSize = [self folderSizeAtPath:cachePath];
//        ANLog(@"%@", [NSThread currentThread]);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.cache = [NSString stringWithFormat:@"%.2fM",fileSize];
//            ANLog(@"%@", [NSThread currentThread]);
//
//        });
//    });
//    
//    
//}
//
//
//
//- (CGFloat)folderSizeAtPath:(NSString *)folderPath
//{
//    NSFileManager *manager = [NSFileManager defaultManager];
//    if (![manager fileExistsAtPath:folderPath]) {
//        return 0;
//    }
//    
//    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
//    
//    NSString *fileName = nil;
//    long long folderSize = 0;
//    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
//        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
//        folderSize += [self fileSizeAtPath:fileAbsolutePath];
//    }
//    return folderSize/(1024.0*1024.0);
//}
//
//- (long long)fileSizeAtPath:(NSString *)filePath
//{
//    NSFileManager* manager = [NSFileManager defaultManager];
//    if ([manager fileExistsAtPath:filePath]){
//        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
//    }
//    return 0;
//
//}






































@end