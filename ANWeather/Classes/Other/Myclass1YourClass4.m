//
//  Myclass1YourClass4.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass1YourClass4.h"

@interface Myclass1YourClass4 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass1YourClass4
{

NSString *_idfx;

NSString *_lio;

NSString *_dsvqtl;

NSString *_tvceuvg;


NSString *_vi;

NSString *_fcsanlh;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithIdfx:@"idfx" WithLio:@"lio" WithDsvqtl:@"dsvqtl" WithTvceuvg:@"tvceuvg" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithIdfx:(NSString *)idfx WithLio:(NSString *)lio WithDsvqtl:(NSString *)dsvqtl WithTvceuvg:(NSString *)tvceuvg  {
    
    _idfx = idfx;
    
    _lio = lio;
    
    _dsvqtl = dsvqtl;
    
    _tvceuvg = tvceuvg;
    
    [self mf_second_thisMethodParamsWithVi:@"vi" WithFcsanlh:@"fcsanlh"  ];
}

- (void)mf_second_thisMethodParamsWithVi:(NSString *)vi WithFcsanlh:(NSString *)fcsanlh  {
    
    _vi = vi;
    
    _fcsanlh = fcsanlh;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"idfx",@"lio",@"dsvqtl",@"tvceuvg"];
    return name;
}


@end

