//
//  Myclass1YourClass2.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass1YourClass2.h"

@interface Myclass1YourClass2 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass1YourClass2
{

NSString *_pthjunc;

NSString *_fbcy;

NSString *_hmxszpr;

NSString *_vydd;


NSString *_dgqiovf;

NSString *_npwb;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithPthjunc:@"pthjunc" WithFbcy:@"fbcy" WithHmxszpr:@"hmxszpr" WithVydd:@"vydd" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithPthjunc:(NSString *)pthjunc WithFbcy:(NSString *)fbcy WithHmxszpr:(NSString *)hmxszpr WithVydd:(NSString *)vydd  {
    
    _pthjunc = pthjunc;
    
    _fbcy = fbcy;
    
    _hmxszpr = hmxszpr;
    
    _vydd = vydd;
    
    [self mf_second_thisMethodParamsWithDgqiovf:@"dgqiovf" WithNpwb:@"npwb"  ];
}

- (void)mf_second_thisMethodParamsWithDgqiovf:(NSString *)dgqiovf WithNpwb:(NSString *)npwb  {
    
    _dgqiovf = dgqiovf;
    
    _npwb = npwb;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"pthjunc",@"fbcy",@"hmxszpr",@"vydd"];
    return name;
}


@end

