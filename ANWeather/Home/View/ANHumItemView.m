//
//  ANHumItemView.m
//  ANWeather
//
//  Created by a on 16/1/7.
//  Copyright (c) 2016年 YongChaoAn. All rights reserved.
//

#import "ANHumItemView.h"
#import "ANWeatherData.h"


@interface ANHumItemView ()
@property (weak, nonatomic) IBOutlet UILabel *humLabel;

 @end

@implementation ANHumItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
}

+ (instancetype)view
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"ANHumItemView" owner:nil options:0 ] lastObject];
    
}

-(void)setWeatherData:(ANWeatherData *)weatherData
{
    _weatherData = weatherData;
    // 设置湿度
    
    NSString *hum = [NSString stringWithFormat:@"%@%%", weatherData.now.hum];
    NSMutableAttributedString *humAttr = [[NSMutableAttributedString alloc] initWithString:hum];
    [humAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(hum.length-1, 1)];
    [humAttr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(hum.length-1, 1)];
    self.humLabel.attributedText = humAttr;
     
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
