//
//  Myclass1YourClass1.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass1YourClass1.h"

@interface Myclass1YourClass1 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass1YourClass1
{

NSString *_prkglrx;

NSString *_mutlo;

NSString *_cqr;

NSString *_eajcst;


NSString *_rec;

NSString *_mlgfhtk;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithPrkglrx:@"prkglrx" WithMutlo:@"mutlo" WithCqr:@"cqr" WithEajcst:@"eajcst" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithPrkglrx:(NSString *)prkglrx WithMutlo:(NSString *)mutlo WithCqr:(NSString *)cqr WithEajcst:(NSString *)eajcst  {
    
    _prkglrx = prkglrx;
    
    _mutlo = mutlo;
    
    _cqr = cqr;
    
    _eajcst = eajcst;
    
    [self mf_second_thisMethodParamsWithRec:@"rec" WithMlgfhtk:@"mlgfhtk"  ];
}

- (void)mf_second_thisMethodParamsWithRec:(NSString *)rec WithMlgfhtk:(NSString *)mlgfhtk  {
    
    _rec = rec;
    
    _mlgfhtk = mlgfhtk;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"prkglrx",@"mutlo",@"cqr",@"eajcst"];
    return name;
}


@end

