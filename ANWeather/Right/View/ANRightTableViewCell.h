//
//  ANRightTableViewCell.h
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ANRightTableViewCell;
@protocol ANRightTableViewCellDelegate <NSObject>

@optional
- (void)rightTableViewCellDidClickDelBtnAtCell:(ANRightTableViewCell *)cell;

@end

@interface ANRightTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *delCityBtn;
@property (weak, nonatomic) IBOutlet UIImageView *locIcon;

@property (weak, nonatomic)id<ANRightTableViewCellDelegate> delegate;


@property (weak, nonatomic) IBOutlet UILabel *cityName;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
