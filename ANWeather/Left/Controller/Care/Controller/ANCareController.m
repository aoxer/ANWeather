//
//  ANCareController.m
//  ANWeather
//
//  Created by a on 16/1/5.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANCareController.h"
#import "UMSocial.h"
#import "UMSocialShakeService.h"
#import "UMSocialScreenShoter.h"
@interface ANCareController ()<UMSocialUIDelegate>

@end

@implementation ANCareController
-(BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //设置第一响应者
    [self becomeFirstResponder];
}
//在响应摇一摇动作方法内得到屏幕截图
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent*)event
{
    if(motion == UIEventSubtypeMotionShake)
    {
        UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
        [UMSocialSnsService presentSnsIconSheetView:self appKey:ANUMAppKey shareText:@"分享文字" shareImage:image shareToSnsNames:nil delegate:nil];
        //下面使用应用类型截屏，如果是cocos2d游戏或者其他类型，使用相应的截屏对象
        //UIImage *image = [[UMSocialScreenShoterDefault screenShoter] getScreenShot];
    }
}
//在摇一摇的回调方法弹出分享面板
-(UMSocialShakeConfig)didShakeWithShakeConfig
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:ANUMAppKey shareText:@"你的分享文字" shareImage:nil shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline] delegate:nil];
    //下面返回值控制是否显示分享编辑页面、是否显示截图、是否有音效，UMSocialShakeConfigNone表示都不显示
    return UMSocialShakeConfigNone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self.sideMenuViewController Action:@selector(presentLeftMenuViewController) andImageName:@"back" andImageNameHighlight:@"back"];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [UMSocialShakeService setShakeToShareWithTypes:@[UMShareToSina,UMShareToWechatSession]
                                         shareText:@"share"
                                      screenShoter:[UMSocialScreenShoterDefault screenShoter]
                                  inViewController:self
                                          delegate:self];
    
    // 不需要响应摇一摇动作调用如下代码：
    [UMSocialShakeService unShakeToSns];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    NSArray *list = @[UMShareToSina, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToInstagram, UMShareToQzone, UMShareToQQ, UMShareToTwitter, UMShareToTumblr];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:ANUMAppKey
                                      shareText:@"关心好友"
                                     shareImage:[UIImage imageNamed:@"city"]
                                shareToSnsNames:list
                                       delegate:self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
