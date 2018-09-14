//
//  Myclass2YourClass4.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass2YourClass4.h"

@interface Myclass2YourClass4 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass2YourClass4
{

NSString *_jjxr;

NSString *_ntnn;

NSString *_krqw;

NSString *_xxlon;


NSString *_uvajs;

NSString *_dxsfomv;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithJjxr:@"jjxr" WithNtnn:@"ntnn" WithKrqw:@"krqw" WithXxlon:@"xxlon" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithJjxr:(NSString *)jjxr WithNtnn:(NSString *)ntnn WithKrqw:(NSString *)krqw WithXxlon:(NSString *)xxlon  {
    
    _jjxr = jjxr;
    
    _ntnn = ntnn;
    
    _krqw = krqw;
    
    _xxlon = xxlon;
    
    [self mf_second_thisMethodParamsWithUvajs:@"uvajs" WithDxsfomv:@"dxsfomv"  ];
}

- (void)mf_second_thisMethodParamsWithUvajs:(NSString *)uvajs WithDxsfomv:(NSString *)dxsfomv  {
    
    _uvajs = uvajs;
    
    _dxsfomv = dxsfomv;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"jjxr",@"ntnn",@"krqw",@"xxlon"];
    return name;
}


@end

