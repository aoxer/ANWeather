//
//  ANWindmill.m
//  ANWeather
//
//  Created by a on 16/1/9.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANWindmill.h"
#import "ArknowM.h"

@interface ANWindmill()
/**
 *  扇叶
 */
@property (weak, nonatomic) IBOutlet UIImageView *blade;

/**
 * 风速
 */
@property (assign, nonatomic)CGFloat spd;

@property (strong, nonatomic)CADisplayLink *link;

@end
@implementation ANWindmill

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANWindmill" owner:nil options:0 ] lastObject];
}

- (void)setNowm:(ArknowM *)nowm
{
    _nowm = nowm;
    // 设置风速
    self.spd = nowm.wind_spd.floatValue / 3.6 / 3; // /3.6为转换m/s
    self.link.paused = NO;
    
    // 设置显示风向和风速
}



- (CADisplayLink *)link
{
    if (_link == nil) {
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _link = link;
    }
    return _link;
}

- (void)update
{
    _blade.transform = CGAffineTransformRotate(_blade.transform, ANRadian(self.spd));
     
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    _blade.userInteractionEnabled = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _link.paused = NO;
    });
}



 
@end
