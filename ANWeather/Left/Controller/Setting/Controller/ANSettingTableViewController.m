//
//  ANSettingTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

 #import "ANSettingTableViewController.h"
#import "MBProgressHUD+MJ.h" 
#define ANTabViewHeight 50

@interface ANSettingTableViewController ()

@property (copy, nonatomic)NSString *cache;
/**
 * 大小手模式
 */
@property (copy, nonatomic)NSString *bigSmallHandMode;
/**
 * 风力单位
 */
@property (copy, nonatomic)NSString *windScaleSpeedMode;
/**
 * 温度单位
 */
@property (copy, nonatomic)NSString *tmpMode;
/**
 *  摇一摇开关
 */
@property (weak, nonatomic)UISwitch *switchBtn;
/**
 *  底部按钮
 */
@property (weak, nonatomic)UIView *tabbarView;


@end

@implementation ANSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置tableView
    [self setupTableView];
  
    // 设置tabbar
    [self setupTabbarView];
    
    // 开源许可
    [self github];
}

- (void)github
{
    UILabel *githubLabel = [[UILabel alloc] init];
    githubLabel.text = @"项目已开源";
    githubLabel.textColor = [UIColor lightGrayColor];
    githubLabel.font = [UIFont systemFontOfSize:12];
    githubLabel.textAlignment = NSTextAlignmentCenter;
    githubLabel.frame = CGRectMake(0, -35, ANScreenWidth, 15);
    [self.tabbarView addSubview:githubLabel];
    
    UILabel *address = [[UILabel alloc] init];
    address.text = @"https://github.com/aoxer/ANWeather";
    address.textColor = [UIColor lightGrayColor];
    address.font = [UIFont systemFontOfSize:12];

    address.textAlignment = NSTextAlignmentCenter;
    address.frame = CGRectMake(0, -20, ANScreenWidth, 15);
    [self.tabbarView addSubview:address];

}

- (void)setupTabbarView
{
    // 容器
    UIView *tabbarView = [[UIView alloc] init];
    tabbarView.frame = CGRectMake(0, ANScreenHeight - 64 - ANTabViewHeight, ANScreenWidth, ANTabViewHeight);
   
    // 线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ANScreenWidth, 1)];
    line.backgroundColor = ANColor(222, 222, 222, 1);
    
    // 按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, ANTabViewHeight, ANTabViewHeight);
    [btn addTarget:self.sideMenuViewController action:@selector(presentLeftMenuViewController) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加
    [tabbarView addSubview:btn];
    [tabbarView addSubview:line];
    
    
    tabbarView.backgroundColor = ANNavBarColor;
    [self.view addSubview:tabbarView];
    
    self.tabbarView = tabbarView;
    
}

 - (void)setupTableView
{
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = ANColor(217, 217, 223, 1.0);
    
    self.navigationController.navigationBar.backgroundColor = ANNavBarColor;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
      
    cell.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"温度单位";
                cell.detailTextLabel.text = self.tmpMode;
                
                if ([ANSettingTool isC]) {
                    cell.imageView.image = [UIImage imageNamed:@"isC"];
                } else {
                    cell.imageView.image = [UIImage imageNamed:@"isF"];
                }
            } else if (indexPath.row == 1){
                
                cell.textLabel.text = @"风力单位";
                cell.detailTextLabel.text = self.windScaleSpeedMode;
                cell.imageView.image = [UIImage imageNamed:@"wind"];
            }
            
            
            
            break;
            
        case 1:
 
            cell.textLabel.text = @"清空缓存";
            cell.detailTextLabel.text = [self getCacheSize];
            if ([[self getCacheSize] isEqualToString:@""]) {
                cell.imageView.image = [UIImage imageNamed:@"file"];
            } else {
                cell.imageView.image = [UIImage imageNamed:@"files"];
            }

            
            break;
            
        case 2:
            
            cell.textLabel.text = @"给我打分";
            cell.imageView.image = [UIImage imageNamed:@"comments"];
            
        break;
            
        case 3:
        {
            
            // 读取沙盒里的版本号
            NSString *versionKey = @"CFBundleVersion";
            // 当前版本号
            NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][versionKey];
            cell.userInteractionEnabled = NO;
            cell.textLabel.text = @"版本信息";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@.0", currentVersion];
            cell.imageView.image = [UIImage imageNamed:@"an_logo"];
        }
            break;
 
        default:
            break;
    }
    return cell;
    
}
/**
 *  创建switch
 *
 *  @param cell 放到哪个cell上
 */
//- (void)switchBtnAtCell:(UITableViewCell *)cell
//{
//    UISwitch *switchBtn = [[UISwitch alloc] init];
//    [ANSettingTool isShakeEnable] ? (switchBtn.on = YES) : (switchBtn.on = NO);
//    switchBtn.centerY = cell.centerY;
//    switchBtn.x = cell.width - switchBtn.width - 20;
//    [cell.contentView addSubview:switchBtn];
//    
//    self.switchBtn = switchBtn;
//}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    
                    // 是摄氏度嘛
                    if ([ANSettingTool isC]) {
                        self.tmpMode = @"°F";
                    } else {
                        self.tmpMode = @"°C";
                    }
                    
                    // 转为华氏并存到数据库
                    [ANSettingTool updateC:![ANSettingTool isC]];
                    break;
                    
                case 1:
                    
                    [ANSettingTool isWindScale] ? (self.windScaleSpeedMode = @"km/h") : (self.windScaleSpeedMode = @"风力等级");
                    
                    [ANSettingTool updateWindScale:![ANSettingTool isWindScale]];

                    break;
                    
                default:
                    break;
            }
            
            break;
            
            
        case 1:
            // 清空缓存
            
            [self myClearCacheAction];
            self.cache = [self getCacheSize];
             break;
            
        case 2:
            {
                //去评分
                NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=1088526122" ];
                if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
                    str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id1088526122"];
                }
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
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
    
    NSString *text = nil;
    
    if (sumSize <1024) {
        text = @"";
    } else if (sumSize>=1024 && sumSize <1024*1024) {
        text = [NSString stringWithFormat:@"%lldKB", sumSize / 1024];
    } else {
        CGFloat floatSize = sumSize/1024/1024;
        text = [NSString stringWithFormat:@"%.2fM", floatSize];
    }
    
    return text;
    
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
    
    [MBProgressHUD showSuccess:@"清理成功"];
    
}

/**
 *  打开相机
 */
//- (IBAction)openCamera
//{
//    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
//}


/**
 *  打开相册
 */
//- (IBAction)openAlbum
//{
//    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
//}

#warning TODO 选择图片设置背景
/**
 *  打开图片选择控制器
 */
//- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
//{
//    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    ipc.sourceType = type;
//    ipc.delegate = self;
//    
//    [self presentViewController:ipc animated:YES completion:nil];
//    
//}

#pragma mark UIImagePickerControllerDelegate
/**
 *  从imagePickerController选择完图片后就调用, 拍照完毕或者选择相册完毕
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    // info中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
//    [self.photosView addPhoto:image];
}



- (NSString *)windScaleSpeedMode
{
    if (!_windScaleSpeedMode) {
        _windScaleSpeedMode = [ANSettingTool isWindScale] ? @"风力等级" : @"km/h";
    }
    return _windScaleSpeedMode;
}

- (NSString *)tmpMode
{
    if (!_tmpMode) {
        _tmpMode = [ANSettingTool isC] ? @"°C" : @"°F";
    }
    return _tmpMode;
}

- (NSString *)bigSmallHandMode
{
    if (!_bigSmallHandMode) {
        _bigSmallHandMode = [ANSettingTool isBigHand] ? @"大手模式" : @"小手模式";
    }
    return _bigSmallHandMode;
}









@end