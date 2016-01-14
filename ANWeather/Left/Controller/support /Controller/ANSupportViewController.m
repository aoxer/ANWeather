//
//  ANSupportViewController.m
//  ANWeather
//
//  Created by a on 16/1/14.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANSupportViewController.h"

@interface ANSupportViewController () 

@end

@implementation ANSupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
  
- (IBAction)left{
    
    [self.sideMenuViewController presentLeftMenuViewController];
}

- (IBAction)home {
    [self.sideMenuViewController backToHomeViewController];
}


@end
