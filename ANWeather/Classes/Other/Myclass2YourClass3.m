//
//  Myclass2YourClass3.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass2YourClass3.h"

@interface Myclass2YourClass3 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass2YourClass3
{

NSString *_nmpzx;

NSString *_tmzj;

NSString *_ur;

NSString *_qxmn;


NSString *_wbsxxcd;

NSString *_uqrqp;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithNmpzx:@"nmpzx" WithTmzj:@"tmzj" WithUr:@"ur" WithQxmn:@"qxmn" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithNmpzx:(NSString *)nmpzx WithTmzj:(NSString *)tmzj WithUr:(NSString *)ur WithQxmn:(NSString *)qxmn  {
    
    _nmpzx = nmpzx;
    
    _tmzj = tmzj;
    
    _ur = ur;
    
    _qxmn = qxmn;
    
    [self mf_second_thisMethodParamsWithWbsxxcd:@"wbsxxcd" WithUqrqp:@"uqrqp"  ];
}

- (void)mf_second_thisMethodParamsWithWbsxxcd:(NSString *)wbsxxcd WithUqrqp:(NSString *)uqrqp  {
    
    _wbsxxcd = wbsxxcd;
    
    _uqrqp = uqrqp;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"nmpzx",@"tmzj",@"ur",@"qxmn"];
    return name;
}


@end

