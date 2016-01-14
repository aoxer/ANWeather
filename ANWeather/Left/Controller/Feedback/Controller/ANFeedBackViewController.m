//
//  ANFeedBackViewController.m
//  ANWeather
//
//  Created by a on 16/1/14.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANFeedBackViewController.h"

@interface ANFeedBackViewController () 

@end

@implementation ANFeedBackViewController

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
