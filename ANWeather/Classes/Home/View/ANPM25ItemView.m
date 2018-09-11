//
//  ANPM25ItemView.m
//  大安天气
//
//  Created by a on 15/12/24.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANPM25ItemView.h"
#import "MSSimpleGauge.h"
#import "ArknowM.h"
#define ANAlpha 0.3
@interface ANPM25ItemView ()


/**
 *  pm2.5的label
 */
@property (weak, nonatomic) IBOutlet UILabel *pm2_5;


/**
 *  空气质量的label
 */
@property (weak, nonatomic) IBOutlet UILabel *qltyLabel;


/**
 *  仪表盘view
 */
@property (weak, nonatomic) IBOutlet UIView *gaugeView;
/**
 *  仪表盘
 */
@property (strong, nonatomic)MSSimpleGauge *bigGauge;
/**
 *  是否为空气质量
 */
@property (assign, nonatomic)BOOL isQlty;

@end

@implementation ANPM25ItemView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [self setup];
    [self setNowm:_nowm];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.cornerRadius = ANCornerRadius;
    gradient.shadowColor = [UIColor blackColor].CGColor;
    gradient.shadowOffset = CGSizeMake(1.5, 1.5);
    gradient.shadowOpacity = 0.5;


    gradient.frame = rect;
    gradient.colors = [NSArray arrayWithObjects:(id)ANColor(255, 255, 255, 0.1).CGColor,
                       (id)ANItemBackgroundColor, nil];
    [self.layer insertSublayer:gradient atIndex:0];

}


- (void)setup
{
        _bigGauge = [[MSSimpleGauge alloc] initWithFrame:_gaugeView.bounds];
        _bigGauge.backgroundColor = ANClearColor;
        _bigGauge.startAngle = 0;
        _bigGauge.endAngle = 180;
        [_gaugeView addSubview:_bigGauge];
    
    [self setNeedsDisplay];
}

+ (instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ANPM25ItemView" owner:nil options:0 ] lastObject];
    
}

-(void)setNowm:(ArknowM *)nowm
{
    _nowm = nowm;
    
    
    CGFloat pm2_5 = nowm.pm25.doubleValue;

    if (nowm.pm25 == nil) {
        // 如果该城市没有pm2.5做点啥
        self.isQlty = YES;
    }
    
    // 显示空气质量
    if (self.isQlty) {

        self.pm2_5.hidden = YES;
        self.qltyLabel.hidden = NO;
        self.qltyLabel.font = ANLightFontSize17;
        // 空气质量
        if (!nowm.qlty.length) {
            self.qltyLabel.text = @"优";
        } else {
            self.qltyLabel.text = nowm.qlty;
        }

    } else { // pm2.5

        self.pm2_5.hidden = NO;
        self.qltyLabel.hidden = YES;

        // pm2.5
        if (!nowm.pm25.length) {
            self.pm2_5.text = @"";
        } else {

            NSString *pm = [NSString stringWithFormat:@" PM2.5 %@", nowm.pm25];
            NSMutableAttributedString *humAttr = [[NSMutableAttributedString alloc] initWithString:pm];
            [humAttr addAttribute:NSFontAttributeName value:ANLightFontSize12 range:NSMakeRange(0, 6)];
            [humAttr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 6)];
            [humAttr addAttribute:NSFontAttributeName value:ANLightFontSize17 range:NSMakeRange(7, nowm.pm25.length)];

             self.pm2_5.attributedText = humAttr;
        }

    }




    // 指针
    [self.bigGauge setValue:pm2_5 / 3 animated:YES] ;

    if (pm2_5 > 0 && pm2_5 <= 50) {
        self.bigGauge.fillArcFillColor = ANColor(0, 255, 0, ANAlpha);
    } else if (pm2_5 > 50 && pm2_5 <= 100) {
        self.bigGauge.fillArcFillColor = ANColor(255, 255, 0, ANAlpha);
    } else if (pm2_5 > 100 && pm2_5 <= 150) {
        self.bigGauge.fillArcFillColor = ANColor(255, 155, 0, ANAlpha);
    } else if (pm2_5 > 150 && pm2_5 <= 200) {
        self.bigGauge.fillArcFillColor = ANColor(255, 40, 40, ANAlpha);
    } else if (pm2_5 > 200 && pm2_5 <= 300) {
        self.bigGauge.fillArcFillColor = ANColor(255, 0, 0, ANAlpha);
    }  else if (pm2_5 > 300) {
        self.bigGauge.fillArcFillColor = ANColor(255, 0, 255, ANAlpha);
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self setNowm:_nowm];
    self.isQlty = !self.isQlty;    

}


@end
