//
//  UIBarButtonItem+Extension.m
//  大安微博
//
//  Created by a on 15/10/27.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *  @param target             点击item后调用谁的方法
 *  @param action             点击item后调用target的哪个方法
 *  @param imageName          图片名称
 *  @param imageNameHighlight 高亮图片名称
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action andImageName:(NSString *)imageName andImageNameHighlight:(NSString *)imageNameHighlight
{
    // 设置按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.size = CGSizeMake(30, 30);
    // 监听点击
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置按钮图片
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageNameHighlight] forState:UIControlStateHighlighted];
    // 设置size
//    btn.size = btn.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}



@end
