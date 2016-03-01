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

- (void)awakeFromNib{
    
    [super awakeFromNib];
    // 添加删除按钮
    UIButton *delCityBtn = [[UIButton alloc] init];
    delCityBtn.frame = CGRectMake(self.width - 40, 0, 30, self.height);
    [delCityBtn setImage:[UIImage imageNamed:@"del"] forState:UIControlStateNormal];
    [delCityBtn addTarget:self action:@selector(delCity) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:delCityBtn];
    self.delCityBtn = delCityBtn;
}

- (IBAction)delCity {
    
    if ([self.delegate respondsToSelector:@selector(rightTableViewCellDidClickDelBtnAtCell:)]) {
        [self.delegate rightTableViewCellDidClickDelBtnAtCell:self];
    }
    
}



/**
 *  根据xib创建cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cities";
    ANRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ANRightTableViewCell" owner:nil options:0] lastObject];
        cell.textLabel.font = [UIFont systemFontOfSize:7];

    }
    
    return cell;
}




 @end
