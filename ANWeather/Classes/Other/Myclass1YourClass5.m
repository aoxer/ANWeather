//
//  Myclass1YourClass5.m
//  asd
//
//  Created by 高源 on 2017/7/13.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "Myclass1YourClass5.h"

@interface Myclass1YourClass5 ()

@property (nonatomic, strong) NSString *name;

@end

@implementation Myclass1YourClass5
{

NSString *_vest;

NSString *_xvjysn;

NSString *_ui;

NSString *_wf;


NSString *_inaeok;

NSString *_ebvlw;

}

- (instancetype)init {
    self = [super init];
    if (self) {

        [self mf_first_WithVest:@"vest" WithXvjysn:@"xvjysn" WithUi:@"ui" WithWf:@"wf" ];
        self.name = [self mf_third_returnValueMethod];
    }
    return self;
}


- (void)mf_first_WithVest:(NSString *)vest WithXvjysn:(NSString *)xvjysn WithUi:(NSString *)ui WithWf:(NSString *)wf  {
    
    _vest = vest;
    
    _xvjysn = xvjysn;
    
    _ui = ui;
    
    _wf = wf;
    
    [self mf_second_thisMethodParamsWithInaeok:@"inaeok" WithEbvlw:@"ebvlw"  ];
}

- (void)mf_second_thisMethodParamsWithInaeok:(NSString *)inaeok WithEbvlw:(NSString *)ebvlw  {
    
    _inaeok = inaeok;
    
    _ebvlw = ebvlw;
    
    [self mf_third_returnValueMethod];
}

- (NSString *)mf_third_returnValueMethod {
    NSString *name = [NSString stringWithFormat:@"%@%@%@%@",@"vest",@"xvjysn",@"ui",@"wf"];
    return name;
}


@end

