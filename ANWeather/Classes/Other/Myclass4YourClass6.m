//
//  Myclass4YourClass6.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass4YourClass6.h"

@interface Myclass4YourClass6 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass4YourClass6
{

NSString *_brkjjz;

NSString *_nusiu;

NSString *_zfhpt;

NSString *_lepb;


NSString *_fb;

NSString *_ipjct;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithBrkjjz:@"brkjjz" WithNusiu:@"nusiu" WithZfhpt:@"zfhpt" WithLepb:@"lepb" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithBrkjjz:(NSString *)brkjjz WithNusiu:(NSString *)nusiu WithZfhpt:(NSString *)zfhpt WithLepb:(NSString *)lepb  {
    
    _brkjjz = brkjjz;
    
    _nusiu = nusiu;
    
    _zfhpt = zfhpt;
    
    _lepb = lepb;
    
    [self mf_second_thisMethodParamsWithFb:@"fb" WithIpjct:@"ipjct"  ];
}

- (void)mf_second_thisMethodParamsWithFb:(NSString *)fb WithIpjct:(NSString *)ipjct  {
    
    _fb = fb;
    
    _ipjct = ipjct;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"brkjjz",@"nusiu",@"zfhpt",@"lepb"];
    return name;
}


@end

