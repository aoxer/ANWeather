//
//  ArkBMKAnnotationView.m
//  ANWeather
//
//  Created by 小华 on 2018/9/11.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

#import "ArkBMKAnnotationView.h"
#import "ArkBMKAnnotation.h"
#import "ArknowM.h"

static NSString *annotationViewIdentifier = @"ArkBMKAnnotationView";

@interface ArkBMKAnnotationView ()

@property (nonatomic, strong) UIImageView *pmView; //当前界面的mapView
@property (nonatomic, strong) UILabel *pmL; //当前界面的mapView

@end


@implementation ArkBMKAnnotationView

+ (instancetype)arkBMKAnnotationView:(BMKMapView *)mapView Annotation:(id<BMKAnnotation>)annotation;
{
    /**
     根据指定标识查找一个可被复用的标注，用此方法来代替新创建一个标注，返回可被复用的标注
     */
    ArkBMKAnnotationView *annotationView = (ArkBMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewIdentifier];
    
    if (!annotationView) {
        /**
         初始化并返回一个annotationView
         
         @param annotation 关联的annotation对象
         @param reuseIdentifier 如果要重用view，传入一个字符串，否则设为nil，建议重用view
         @return 初始化成功则返回annotationView，否则返回nil
         */
        annotationView = [[ArkBMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewIdentifier];
        //annotationView显示的图片，默认是大头针
        //annotationView.image = nil;
        /**
         默认情况下annotationView的中心点位于annotation的坐标位置，可以设置centerOffset改变
         annotationView的位置，正的偏移使annotationView朝右下方移动，负的朝左上方，单位是像素
         */
        annotationView.centerOffset = CGPointMake(0, 0);
        /**
         默认情况下, 弹出的气泡位于annotationView正中上方，可以设置calloutOffset改变annotationView的
         位置，正的偏移使annotationView朝右下方移动，负的朝左上方，单位是像素
         */
        annotationView.calloutOffset = CGPointMake(0, 0);
        //是否显示3D效果，标注在地图旋转和俯视时跟随旋转、俯视，默认为NO
        annotationView.enabled3D = NO;
        //是否忽略触摸时间，默认为YES
        annotationView.enabled = YES;
        /**
         开发者不要直接设置这个属性，若设置，需要在设置后调用BMKMapView的-(void)mapForceRefresh;方法
         刷新地图，默认为NO，当annotationView被选中时为YES
         */
        annotationView.selected = NO;
        //annotationView被选中时，是否显示气泡（若显示，annotation必须设置了title），默认为YES
        annotationView.canShowCallout = YES;
        /**
         显示在气泡左侧的view(使用默认气泡时，view的width最大值为32，
         height最大值为41，大于则使用最大值）
         */
        annotationView.leftCalloutAccessoryView = nil;
        /**
         显示在气泡右侧的view(使用默认气泡时，view的width最大值为32，
         height最大值为41，大于则使用最大值）
         */
        annotationView.rightCalloutAccessoryView = nil;
        /**
         annotationView的颜色： BMKPinAnnotationColorRed，BMKPinAnnotationColorGreen，
         BMKPinAnnotationColorPurple
         */
        //当设为YES并实现了setCoordinate:方法时，支持将annotationView在地图上拖动
        annotationView.draggable = YES;
        //当前view的拖动状态
        //annotationView.dragState;
    }
    
    return  annotationView;
}

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        [self setBounds:CGRectMake(0.f, 0.f, 80.f, 18.f)];

        self.pmView=[UIImageView new];
        self.pmView.image=[UIImage imageNamed:@"pm2.5"];
        self.pmView.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:self.pmView];
        
        self.pmL=[UILabel new];
        self.pmL.textAlignment=1;
        self.pmL.font=[UIFont systemFontOfSize:10];
        self.pmL.textColor=[UIColor whiteColor];
        [self addSubview:self.pmL];
        
        self.layer.cornerRadius=3;
        self.clipsToBounds=YES;
                
    }
    return self;
}

-(void)setArkanM:(ArkBMKAnnotation *)arkanM
{
    _arkanM=arkanM;
    
    self.pmView.frame=CGRectMake(0, 0, self.size.height, self.size.height);
    
    self.pmL.text=[NSString stringWithFormat:@"%@%@",arkanM.nowm.air_sta,arkanM.nowm.pm25];
    
    CGSize size = [self.pmL.text sizeWithAttributes:@{NSFontAttributeName: self.pmL.font}];
    
    self.width=size.width+self.size.height+10;
    
    self.pmL.frame=CGRectMake(CGRectGetMaxX(self.pmView.frame), 0, self.size.width-self.size.height, self.size.height);

    int pm25=self.arkanM.nowm.pm25.intValue;
    UIColor *bgc=ANColor(43, 193, 93, 0.9);
    if (pm25>50) {
        bgc=ANColor(247, 195, 89, 0.9);
    }else if(pm25>100){
        bgc=ANColor(255, 65, 0, 0.9);
    }
    self.backgroundColor=bgc;


}





@end
