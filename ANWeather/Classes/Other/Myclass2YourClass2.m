//
//  Myclass2YourClass2.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass2YourClass2.h"

@interface Myclass2YourClass2 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass2YourClass2
{

NSString *_nleroul;

NSString *_yrlmiwz;

NSString *_xwnaue;

NSString *_vc;


NSString *_fyrc;

NSString *_vd;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithNleroul:@"nleroul" WithYrlmiwz:@"yrlmiwz" WithXwnaue:@"xwnaue" WithVc:@"vc" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithNleroul:(NSString *)nleroul WithYrlmiwz:(NSString *)yrlmiwz WithXwnaue:(NSString *)xwnaue WithVc:(NSString *)vc  {
    
    _nleroul = nleroul;
    
    _yrlmiwz = yrlmiwz;
    
    _xwnaue = xwnaue;
    
    _vc = vc;
    
    [self mf_second_thisMethodParamsWithFyrc:@"fyrc" WithVd:@"vd"  ];
}

- (void)mf_second_thisMethodParamsWithFyrc:(NSString *)fyrc WithVd:(NSString *)vd  {
    
    _fyrc = fyrc;
    
    _vd = vd;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"nleroul",@"yrlmiwz",@"xwnaue",@"vc"];
    return name;
}


@end

