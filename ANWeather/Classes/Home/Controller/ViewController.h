//
//  ViewController.h
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANRightTableViewController.h"
@interface ViewController : UITableViewController <ANRightTableViewControllerDelegate>

/**
 *  已选城市城市
 */
@property (copy, nonatomic)NSString *selectedCity;
/**
 *  是否从左边进来
 */
@property (assign, nonatomic)BOOL isFromLeft;
/**
 *  是否从左边进来
 */
@property (assign, nonatomic)BOOL isFromRight;

/**
 *  是否分享
 */
@property (assign, nonatomic)BOOL isFromcare;


 @end

