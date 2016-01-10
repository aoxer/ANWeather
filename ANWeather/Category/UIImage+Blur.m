//
//  UIImage+Blur.m
//  ANWeather
//
//  Created by a on 16/1/10.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "UIImage+Blur.h"

@implementation UIImage (Blur)
/**
 *  图片模糊
 */
- (UIImage *)blurImageWithvalue:(CGFloat)value;
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:self];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:value] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage = [UIImage imageWithCGImage:cgImage];
    
    return blurImage;
}
@end
