//
//  ANRightTableViewCell.m
//  ANWeather
//
//  Created by a on 15/12/30.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANRightTableViewCell.h"

@interface ANRightTableViewCell ()



@end

@implementation ANRightTableViewCell

 

 
- (IBAction)delCity {
    
    if ([self.delegate respondsToSelector:@selector(rightTableViewCellDidClickDelBtnAtCell:)]) {
        [self.delegate rightTableViewCellDidClickDelBtnAtCell:self];
    }
    
    ANLog(@"delCity %zd", self.tag);
}



/**
 *  根据xib创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"citys";
    ANRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ANRightTableViewCell" owner:nil options:0] lastObject];
    }
    
    return cell;
}




 @end
