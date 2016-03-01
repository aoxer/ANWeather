//
//  ANLeftTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/26.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANLeftTableViewController.h"

#import "MBProgressHUD+MJ.h"
#import <MessageUI/MessageUI.h>
#import "ViewController.h"
#import "ANSettingTableViewController.h"
#import "ANSupportViewController.h"
#import "ANFeedBackViewController.h"
#import "ANCareViewController.h"
#import "ANAboutViewController.h"
@interface ANLeftTableViewController ()<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic)NSArray *titles;
@end

@implementation ANLeftTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect tableViewFrame = CGRectMake(0, (ANScreenHeight - 54 * 5) /2.0f, ANScreenWidth, 54*5);
    self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.contentInset = UIEdgeInsetsMake(ANScreenHeight*0.5, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];

    }
    NSArray *images = @[@"left_home", @"left_setting", @"left_write", @"left_mail"];

    cell.textLabel.attributedText = self.titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
            
#warning 待改
        case 0:
        {// 主页
            ViewController *homeVc = [[ViewController alloc] init];
            homeVc.isFromLeft = YES;
             [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController: homeVc] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            
        case 1:
        {
            // 设置
            ANSettingTableViewController *settingVC = [self settingVC];
         
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:settingVC] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            
        case 2:
       
        {
            // 分享
            ANCareViewController *careVC = [[ANCareViewController alloc] init];
            
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:careVC] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;
            
        case 3:
            [self sendEMail];
            break;
            
            
        case 4:
        {
            // 关于
            ANAboutViewController *aboutVC = [[ANAboutViewController alloc] init];
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:aboutVC] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
        }
            break;


        default:
            break;
    }

}
- (ANSettingTableViewController *)settingVC
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ANSettingTableViewController" bundle:nil];
    ANSettingTableViewController *settingVC = [sb instantiateViewControllerWithIdentifier:@"setting"];
    
    return settingVC;
}


#pragma mark 反馈邮件

// 发送邮件
-(void)sendEMail
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}

//可以发送邮件的话
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"我要吐槽"];
    
    // 添加收信人
    NSArray *toRecipients = [NSArray arrayWithObject: @"aoxer@163.com"];
    
    [mailPicker setToRecipients: toRecipients];
    
     // 邮件主体
    [mailPicker setMessageBody:@"哪里不爽？\n我改完让大家爽爽!" isHTML:NO];
    
     [self presentViewController:mailPicker animated:YES completion:nil];
}

// 转到系统邮件
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

// 邮件发送返回
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString *msg;
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            msg = @"邮件发送取消";
            break;
        case MFMailComposeResultSaved:
            msg = @"邮件保存成功";
            [MBProgressHUD showSuccess:msg];
            break;
        case MFMailComposeResultSent:
            msg = @"邮件发送成功";
            [MBProgressHUD showSuccess:msg];
            break;
        case MFMailComposeResultFailed:
            msg = @"邮件发送失败";
            [MBProgressHUD showError:msg];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSArray *)titles
{
    if (!_titles) {
        NSAttributedString *weather = [NSString attrStringWithStr:@"主页"];
        NSAttributedString *setting = [NSString attrStringWithStr:@"设置"];
        NSAttributedString *dafen = [NSString attrStringWithStr:@"分享"];
        NSAttributedString *tucao = [NSString attrStringWithStr:@"吐槽"];

        _titles = @[weather, setting, dafen, tucao];

    }
    return _titles;
}
@end
