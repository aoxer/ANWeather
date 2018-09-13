//
//  Myclass2YourClass5.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass2YourClass5.h"

@interface Myclass2YourClass5 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass2YourClass5
{

NSString *_mmat;

NSString *_ztbhe;

NSString *_mbajiwd;

NSString *_sc;


NSString *_meyg;

NSString *_ycnqcth;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithMmat:@"mmat" WithZtbhe:@"ztbhe" WithMbajiwd:@"mbajiwd" WithSc:@"sc" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithMmat:(NSString *)mmat WithZtbhe:(NSString *)ztbhe WithMbajiwd:(NSString *)mbajiwd WithSc:(NSString *)sc  {
    
    _mmat = mmat;
    
    _ztbhe = ztbhe;
    
    _mbajiwd = mbajiwd;
    
    _sc = sc;
    
    [self mf_second_thisMethodParamsWithMeyg:@"meyg" WithYcnqcth:@"ycnqcth"  ];
}

- (void)mf_second_thisMethodParamsWithMeyg:(NSString *)meyg WithYcnqcth:(NSString *)ycnqcth  {
    
    _meyg = meyg;
    
    _ycnqcth = ycnqcth;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"mmat",@"ztbhe",@"mbajiwd",@"sc"];
    return name;
}


@end

