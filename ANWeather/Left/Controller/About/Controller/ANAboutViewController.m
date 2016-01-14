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
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self.sideMenuViewController Action:@selector(presentLeftMenuViewController) andImageName:@"back" andImageNameHighlight:@"back"];
 
}

- (IBAction)left{
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)home {
    [self.sideMenuViewController backToHomeViewController];
}



@end
