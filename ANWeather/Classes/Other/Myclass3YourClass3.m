//
//  Myclass3YourClass3.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass3YourClass3.h"

@interface Myclass3YourClass3 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass3YourClass3
{

NSString *_vmzcqpl;

NSString *_et;

NSString *_dneaf;

NSString *_ac;


NSString *_cetfm;

NSString *_bjf;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithVmzcqpl:@"vmzcqpl" WithEt:@"et" WithDneaf:@"dneaf" WithAc:@"ac" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithVmzcqpl:(NSString *)vmzcqpl WithEt:(NSString *)et WithDneaf:(NSString *)dneaf WithAc:(NSString *)ac  {
    
    _vmzcqpl = vmzcqpl;
    
    _et = et;
    
    _dneaf = dneaf;
    
    _ac = ac;
    
    [self mf_second_thisMethodParamsWithCetfm:@"cetfm" WithBjf:@"bjf"  ];
}

- (void)mf_second_thisMethodParamsWithCetfm:(NSString *)cetfm WithBjf:(NSString *)bjf  {
    
    _cetfm = cetfm;
    
    _bjf = bjf;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"vmzcqpl",@"et",@"dneaf",@"ac"];
    return name;
}


@end

