//
//  ANSearchBar.m
//  大安微博
//
//  Created by a on 15/10/28.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANSearchBar.h"

@implementation ANSearchBar

+ (instancetype)searchBar
{
    return [[ANSearchBar alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init来创建初始化绝大部分控件, 控件都是没有尺寸
        //    UIImageView *searchIcon = [[UIImageView alloc] init];
        //    searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        
        // 通过initWithImage来初始化UIImageView, UIImageView的尺寸默认就等于image的尺寸
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        searchIcon.height = 30;
        searchIcon.width = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.returnKeyType = UIReturnKeySearch;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}



@end
