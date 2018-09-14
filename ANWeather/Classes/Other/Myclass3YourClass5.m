//
//  Myclass3YourClass5.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass3YourClass5.h"

@interface Myclass3YourClass5 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass3YourClass5
{

NSString *_zsrzp;

NSString *_lj;

NSString *_mjnpo;

NSString *_gvyox;


NSString *_zti;

NSString *_oley;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithZsrzp:@"zsrzp" WithLj:@"lj" WithMjnpo:@"mjnpo" WithGvyox:@"gvyox" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithZsrzp:(NSString *)zsrzp WithLj:(NSString *)lj WithMjnpo:(NSString *)mjnpo WithGvyox:(NSString *)gvyox  {
    
    _zsrzp = zsrzp;
    
    _lj = lj;
    
    _mjnpo = mjnpo;
    
    _gvyox = gvyox;
    
    [self mf_second_thisMethodParamsWithZti:@"zti" WithOley:@"oley"  ];
}

- (void)mf_second_thisMethodParamsWithZti:(NSString *)zti WithOley:(NSString *)oley  {
    
    _zti = zti;
    
    _oley = oley;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"zsrzp",@"lj",@"mjnpo",@"gvyox"];
    return name;
}


@end

