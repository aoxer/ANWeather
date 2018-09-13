//
//  Myclass4YourClass5.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass4YourClass5.h"

@interface Myclass4YourClass5 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass4YourClass5
{

NSString *_xst;

NSString *_gl;

NSString *_bp;

NSString *_nyaaaeh;


NSString *_irolis;

NSString *_us;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithXst:@"xst" WithGl:@"gl" WithBp:@"bp" WithNyaaaeh:@"nyaaaeh" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithXst:(NSString *)xst WithGl:(NSString *)gl WithBp:(NSString *)bp WithNyaaaeh:(NSString *)nyaaaeh  {
    
    _xst = xst;
    
    _gl = gl;
    
    _bp = bp;
    
    _nyaaaeh = nyaaaeh;
    
    [self mf_second_thisMethodParamsWithIrolis:@"irolis" WithUs:@"us"  ];
}

- (void)mf_second_thisMethodParamsWithIrolis:(NSString *)irolis WithUs:(NSString *)us  {
    
    _irolis = irolis;
    
    _us = us;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"xst",@"gl",@"bp",@"nyaaaeh"];
    return name;
}


@end

