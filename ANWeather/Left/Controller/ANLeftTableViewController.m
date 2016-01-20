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
#import "ANAboutViewController.h"
@interface ANLeftTableViewController ()<MFMailComposeViewControllerDelegate>

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
    
    return 5;
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
    NSArray *titles = @[@"Home", @"Settings",@"给我打分", @"吐槽", @"About"];
    NSArray *images = @[@"IconHome", @"IconProfile", @"IconProfile", @"IconSettings", @"IconSettings"];

    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 主页
    ViewController *homeVc = [[ViewController alloc] init];
    homeVc.isFromLeft = YES;
    
    // 设置
    ANSettingTableViewController *settingVC = [self settingVC];
    
    // 神秘选项
    ANSupportViewController *supportVC = [[ANSupportViewController alloc] init];
    
    // 反馈
    ANFeedBackViewController *feedBackVC = [[ANFeedBackViewController alloc] init];
    // 关于
    ANAboutViewController *aboutVC = [[ANAboutViewController alloc] init];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
#warning 待改
        case 0:
             [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController: homeVc] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:settingVC] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 2:
        {
            NSString *str = @"http://www.baidu.com";
            NSURL *url = [NSURL URLWithString:str];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
            
        case 3:
            [self sendEMail];
            break;
            
            
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:aboutVC] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
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
    
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject: @"aoxer@163.com"];
    
    [mailPicker setToRecipients: toRecipients];
    
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





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
