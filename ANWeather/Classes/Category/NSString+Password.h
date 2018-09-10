//
//  NSString+Password.h
//  cnBetaLite
//
//  Created by 小华 on 2018/9/7.
//  Copyright © 2018年 小华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Password)
/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)SHA1;
@end
