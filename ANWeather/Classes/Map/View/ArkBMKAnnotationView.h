//
//  ArkBMKAnnotationView.h
//  ANWeather
//
//  Created by 小华 on 2018/9/11.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

@class ArkBMKAnnotation;

@interface ArkBMKAnnotationView : BMKAnnotationView

@property (nonatomic , strong)ArkBMKAnnotation *arkanM;

+ (instancetype)arkBMKAnnotationView:(BMKMapView *)mapView Annotation:(id<BMKAnnotation>)annotation;

@end
