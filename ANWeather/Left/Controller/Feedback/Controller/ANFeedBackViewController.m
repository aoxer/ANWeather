//
//  ANFeedBackViewController.m
//  ANWeather
//
//  Created by a on 16/1/14.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANFeedBackViewController.h"

@interface ANFeedBackViewController ()<AwesomeMenuDelegate>

@end

@implementation ANFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ANAwesomeMenuHideOrShow
    
    ANAwesomeMenu *awm = [ANAwesomeMenu sharedAwesomeMenu];
    awm.delegate = self;
}

#pragma mark AwesomeMenuDelegate
- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    switch (idx) {
        case 0:
            [self.sideMenuViewController presentLeftMenuViewController];
            //            [ANNotificationCenter postNotificationName:ANCallLeftNotification object:nil];
            break;
            
        case 1:
            [self.sideMenuViewController backToHomeViewController];
            //            [ANNotificationCenter postNotificationName:ANCallHomeNotification object:nil];
            break;
            
        case 2:
            [self.sideMenuViewController presentRightMenuViewController];
            //            [ANNotificationCenter postNotificationName:ANCallRightNotification object:nil];
            break;
            
            
        default:
            break;
    }
}


@end
