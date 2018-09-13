//
//  Myclass3YourClass1.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass3YourClass1.h"

@interface Myclass3YourClass1 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass3YourClass1
{

NSString *_vfvq;

NSString *_jwqb;

NSString *_mutvziz;

NSString *_jifeio;


NSString *_rxazgf;

NSString *_ctgy;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithVfvq:@"vfvq" WithJwqb:@"jwqb" WithMutvziz:@"mutvziz" WithJifeio:@"jifeio" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithVfvq:(NSString *)vfvq WithJwqb:(NSString *)jwqb WithMutvziz:(NSString *)mutvziz WithJifeio:(NSString *)jifeio  {
    
    _vfvq = vfvq;
    
    _jwqb = jwqb;
    
    _mutvziz = mutvziz;
    
    _jifeio = jifeio;
    
    [self mf_second_thisMethodParamsWithRxazgf:@"rxazgf" WithCtgy:@"ctgy"  ];
}

- (void)mf_second_thisMethodParamsWithRxazgf:(NSString *)rxazgf WithCtgy:(NSString *)ctgy  {
    
    _rxazgf = rxazgf;
    
    _ctgy = ctgy;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"vfvq",@"jwqb",@"mutvziz",@"jifeio"];
    return name;
}


@end

