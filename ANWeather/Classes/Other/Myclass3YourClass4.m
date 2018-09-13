//
//  Myclass3YourClass4.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass3YourClass4.h"

@interface Myclass3YourClass4 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass3YourClass4
{

NSString *_zaeeik;

NSString *_pspy;

NSString *_rcyf;

NSString *_meysik;


NSString *_gr;

NSString *_vtv;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithZaeeik:@"zaeeik" WithPspy:@"pspy" WithRcyf:@"rcyf" WithMeysik:@"meysik" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithZaeeik:(NSString *)zaeeik WithPspy:(NSString *)pspy WithRcyf:(NSString *)rcyf WithMeysik:(NSString *)meysik  {
    
    _zaeeik = zaeeik;
    
    _pspy = pspy;
    
    _rcyf = rcyf;
    
    _meysik = meysik;
    
    [self mf_second_thisMethodParamsWithGr:@"gr" WithVtv:@"vtv"  ];
}

- (void)mf_second_thisMethodParamsWithGr:(NSString *)gr WithVtv:(NSString *)vtv  {
    
    _gr = gr;
    
    _vtv = vtv;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"zaeeik",@"pspy",@"rcyf",@"meysik"];
    return name;
}


@end

