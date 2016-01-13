//
//  ANAboutViewController.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANAboutViewController.h"

@interface ANAboutViewController ()

@end

@implementation ANAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ANAwesomeMenuHideOrShow
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self.sideMenuViewController Action:@selector(presentLeftMenuViewController) andImageName:@"back" andImageNameHighlight:@"back"];

//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(callLeft) andImageName:@"top_navigation_menuicon" andImageNameHighlight:nil];
//    
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:nil andImageName:@"location" andImageNameHighlight:nil];
//    self.navigationController.navigationBar.barTintColor = ANColor(40, 40, 40, 0.3);
//    self.navigationController.navigationBar.hidden = YES;
//    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
