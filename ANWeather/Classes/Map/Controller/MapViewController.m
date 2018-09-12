//
//  MapViewController.m
//  ANWeather
//
//  Created by 小华 on 2018/9/11.
//  Copyright © 2018年 YongChaoAn. All rights reserved.
//

#import "MapViewController.h"
#import "ArkBMKAnnotationView.h"
#import "ArknowM.h"
#import "ArkBMKAnnotation.h"
@interface MapViewController ()<BMKMapViewDelegate>

@property (nonatomic, strong) BMKMapView *mapView; //当前界面的mapView
@property (nonatomic, strong) BMKPointAnnotation *annotation; //当前界面的标注
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self createMapView];
    [self createAnnotation];
}

- (void)viewWillAppear:(BOOL)animated {
    //当mapView即将被显示的时候调用，恢复之前存储的mapView状态
    [_mapView viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    //当mapView即将被隐藏的时候调用，存储当前mapView的状态
    [_mapView viewWillDisappear];
}

#pragma mark - Config UI
- (void)configUI {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"pm2.5";
    
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = backButton;

}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)createMapView {
    //将mapView添加到当前视图中
    [self.view addSubview:self.mapView];
    //设置mapView的代理
    _mapView.delegate = self;
    
    CLLocationDegrees la=self.nowm.lat.doubleValue;
    CLLocationDegrees lo=self.nowm.lon.doubleValue;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(la, lo);
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.1, 0.1);
    _mapView.region = BMKCoordinateRegionMake(center, span);
    
    _mapView.zoomLevel = 13;

}

- (void)createAnnotation {
    
    for (NSDictionary *dict in self.nowm.air_now_station) {
        ArknowM *nowm=[ArknowM objectWithKeyValues:dict];
        ArkBMKAnnotation *annotation=[ArkBMKAnnotation new];
        CLLocationDegrees la=nowm.lat.doubleValue;
        CLLocationDegrees lo=nowm.lon.doubleValue;
        annotation.coordinate =  CLLocationCoordinate2DMake(la, lo);
        annotation.nowm=nowm;
        [_mapView addAnnotation:annotation];
    }
 
}

#pragma mark - BMKMapViewDelegate
/**
 根据anntation生成对应的annotationView
 
 @param mapView 地图View
 @param annotation 指定的标注
 @return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[ArkBMKAnnotation class]]) {
        
        ArkBMKAnnotationView *annotationView=[ArkBMKAnnotationView arkBMKAnnotationView:mapView Annotation:annotation];
        annotationView.arkanM=(ArkBMKAnnotation *)annotation;
        return annotationView;
        
    }else{
        return nil;
    }
}

#pragma mark - Lazy loading
- (BMKMapView *)mapView {
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - kViewTopHeight - KiPhoneXSafeAreaDValue)];
    }
    return _mapView;
}




@end
