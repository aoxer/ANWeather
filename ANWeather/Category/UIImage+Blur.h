//
//  UIImage+Blur.h
//  ANWeather
//
//  Created by a on 16/1/10.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Blur)

/**
 *  图片模糊
 */
- (UIImage *)blurImageWithvalue:(CGFloat)value;
@end