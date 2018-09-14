//
//  Myclass4YourClass1.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass4YourClass1.h"

@interface Myclass4YourClass1 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass4YourClass1
{

NSString *_qs;

NSString *_ao;

NSString *_mb;

NSString *_vss;


NSString *_jcwm;

NSString *_tvayp;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithQs:@"qs" WithAo:@"ao" WithMb:@"mb" WithVss:@"vss" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithQs:(NSString *)qs WithAo:(NSString *)ao WithMb:(NSString *)mb WithVss:(NSString *)vss  {
    
    _qs = qs;
    
    _ao = ao;
    
    _mb = mb;
    
    _vss = vss;
    
    [self mf_second_thisMethodParamsWithJcwm:@"jcwm" WithTvayp:@"tvayp"  ];
}

- (void)mf_second_thisMethodParamsWithJcwm:(NSString *)jcwm WithTvayp:(NSString *)tvayp  {
    
    _jcwm = jcwm;
    
    _tvayp = tvayp;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"qs",@"ao",@"mb",@"vss"];
    return name;
}


@end

