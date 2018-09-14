//
//  Myclass3YourClass6.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass3YourClass6.h"

@interface Myclass3YourClass6 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass3YourClass6
{

NSString *_dd;

NSString *_hl;

NSString *_dyp;

NSString *_vznpndp;


NSString *_cmq;

NSString *_ubc;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithDd:@"dd" WithHl:@"hl" WithDyp:@"dyp" WithVznpndp:@"vznpndp" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithDd:(NSString *)dd WithHl:(NSString *)hl WithDyp:(NSString *)dyp WithVznpndp:(NSString *)vznpndp  {
    
    _dd = dd;
    
    _hl = hl;
    
    _dyp = dyp;
    
    _vznpndp = vznpndp;
    
    [self mf_second_thisMethodParamsWithCmq:@"cmq" WithUbc:@"ubc"  ];
}

- (void)mf_second_thisMethodParamsWithCmq:(NSString *)cmq WithUbc:(NSString *)ubc  {
    
    _cmq = cmq;
    
    _ubc = ubc;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"dd",@"hl",@"dyp",@"vznpndp"];
    return name;
}


@end

