//
//  Myclass1YourClass3.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass1YourClass3.h"

@interface Myclass1YourClass3 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass1YourClass3
{

NSString *_tkud;

NSString *_zjs;

NSString *_wfey;

NSString *_buf;


NSString *_dyiksio;

NSString *_myazlcx;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithTkud:@"tkud" WithZjs:@"zjs" WithWfey:@"wfey" WithBuf:@"buf" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithTkud:(NSString *)tkud WithZjs:(NSString *)zjs WithWfey:(NSString *)wfey WithBuf:(NSString *)buf  {
    
    _tkud = tkud;
    
    _zjs = zjs;
    
    _wfey = wfey;
    
    _buf = buf;
    
    [self mf_second_thisMethodParamsWithDyiksio:@"dyiksio" WithMyazlcx:@"myazlcx"  ];
}

- (void)mf_second_thisMethodParamsWithDyiksio:(NSString *)dyiksio WithMyazlcx:(NSString *)myazlcx  {
    
    _dyiksio = dyiksio;
    
    _myazlcx = myazlcx;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"tkud",@"zjs",@"wfey",@"buf"];
    return name;
}


@end

