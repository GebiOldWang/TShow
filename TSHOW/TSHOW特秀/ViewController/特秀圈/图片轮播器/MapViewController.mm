//
//  MapViewController.m
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/13.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreem mainScreen].bounds

#import "MapViewController.h"


@interface MapViewController ()<BMKMapViewDelegate>

@property (nonatomic , weak) BMKMapView * mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    self.mapView = mapView;
    self.view = self.mapView;
    
    [self.mapView setShowsUserLocation:YES];
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    backView.backgroundColor = TSRGBColor(246, 246, 246);
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _locService = [[BMKLocationService alloc]init];

    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
//    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
//    _mapView.mapType = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES; //是否显示定位图层（即我的位置的小圆点）
    _mapView.zoomLevel = 16;//地图显示比例
    
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(18, 32, 24, 24)];
    backBtn.backgroundColor = [UIColor blueColor];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:backBtn];
    
    [self.view addSubview:backView];
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//MapView委托方法，当定位自身时调用
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"!latitude:%f",userLocation.location.coordinate.latitude);//经度
//    NSLog(@"!longtitude:%f",userLocation.location.coordinate.longitude);//纬度
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
//    NSLog(@"!latitude:%f",userLocation.location.coordinate.latitude);//经度
//    NSLog(@"!longtitude:%f",userLocation.location.coordinate.longitude);//纬度
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}


@end
