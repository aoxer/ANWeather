//
//  Myclass2YourClass1.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass2YourClass1.h"

@interface Myclass2YourClass1 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass2YourClass1
{

NSString *_gso;

NSString *_hl;

NSString *_poxbo;

NSString *_ktsr;


NSString *_jpj;

NSString *_wpzlilb;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithGso:@"gso" WithHl:@"hl" WithPoxbo:@"poxbo" WithKtsr:@"ktsr" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithGso:(NSString *)gso WithHl:(NSString *)hl WithPoxbo:(NSString *)poxbo WithKtsr:(NSString *)ktsr  {
    
    _gso = gso;
    
    _hl = hl;
    
    _poxbo = poxbo;
    
    _ktsr = ktsr;
    
    [self mf_second_thisMethodParamsWithJpj:@"jpj" WithWpzlilb:@"wpzlilb"  ];
}

- (void)mf_second_thisMethodParamsWithJpj:(NSString *)jpj WithWpzlilb:(NSString *)wpzlilb  {
    
    _jpj = jpj;
    
    _wpzlilb = wpzlilb;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"gso",@"hl",@"poxbo",@"ktsr"];
    return name;
}


@end

