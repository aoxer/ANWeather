//
//  UIWindow+Version.m
//  ANWeather
//
//  Created by a on 16/2/1.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "UIWindow+Version.h"
#import "ANNewFeatureViewController.h"
#import "ViewController.h"
#import "ANLeftTableViewController.h"
#import "ANRightTableViewController.h"

@implementation UIWindow (Version)

- (void)switchRootViewController
{
    // 判断版本号
    // 读取沙盒里的版本号
    NSString *versionKey = @"CFBundleVersion";
    // 上一次使用的版本(存在沙盒中的版本号)
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    // 当前版本号
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][versionKey];
    
    // 获取主窗口
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [self sideMenuViewController];
    } else {
        self.rootViewController = [[ANNewFeatureViewController alloc] init];
        
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


- (RESideMenu *)sideMenuViewController
{
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    ANLeftTableViewController *leftTableViewController = [[ANLeftTableViewController alloc] init];
    ANRightTableViewController *rightTableViewController = [[ANRightTableViewController alloc] init];
    //    rightTableViewController.delegate = viewController;
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftTableViewController
                                                                   rightMenuViewController:rightTableViewController];
    
    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"clear_d_portrait_blur.jpg"];
    sideMenuViewController.menuPreferredStatusBarStyle = 0; // UIStatusBarStyleLightContent
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewScaleValue = 1.0;
    
    return sideMenuViewController;
}
@end
