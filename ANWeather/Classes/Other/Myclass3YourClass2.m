//
//  Myclass3YourClass2.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass3YourClass2.h"

@interface Myclass3YourClass2 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass3YourClass2
{

NSString *_oqillp;

NSString *_swoz;

NSString *_ouovc;

NSString *_exl;


NSString *_yl;

NSString *_nc;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithOqillp:@"oqillp" WithSwoz:@"swoz" WithOuovc:@"ouovc" WithExl:@"exl" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithOqillp:(NSString *)oqillp WithSwoz:(NSString *)swoz WithOuovc:(NSString *)ouovc WithExl:(NSString *)exl  {
    
    _oqillp = oqillp;
    
    _swoz = swoz;
    
    _ouovc = ouovc;
    
    _exl = exl;
    
    [self mf_second_thisMethodParamsWithYl:@"yl" WithNc:@"nc"  ];
}

- (void)mf_second_thisMethodParamsWithYl:(NSString *)yl WithNc:(NSString *)nc  {
    
    _yl = yl;
    
    _nc = nc;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"oqillp",@"swoz",@"ouovc",@"exl"];
    return name;
}


@end

