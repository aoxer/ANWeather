//
//  Myclass4YourClass4.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass4YourClass4.h"

@interface Myclass4YourClass4 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass4YourClass4
{

NSString *_lxcuvz;

NSString *_ix;

NSString *_yjqskes;

NSString *_rmo;


NSString *_pgn;

NSString *_aqmgrx;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithLxcuvz:@"lxcuvz" WithIx:@"ix" WithYjqskes:@"yjqskes" WithRmo:@"rmo" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithLxcuvz:(NSString *)lxcuvz WithIx:(NSString *)ix WithYjqskes:(NSString *)yjqskes WithRmo:(NSString *)rmo  {
    
    _lxcuvz = lxcuvz;
    
    _ix = ix;
    
    _yjqskes = yjqskes;
    
    _rmo = rmo;
    
    [self mf_second_thisMethodParamsWithPgn:@"pgn" WithAqmgrx:@"aqmgrx"  ];
}

- (void)mf_second_thisMethodParamsWithPgn:(NSString *)pgn WithAqmgrx:(NSString *)aqmgrx  {
    
    _pgn = pgn;
    
    _aqmgrx = aqmgrx;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"lxcuvz",@"ix",@"yjqskes",@"rmo"];
    return name;
}


@end

