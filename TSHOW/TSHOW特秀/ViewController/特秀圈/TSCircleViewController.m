//
//  TSCircleViewController.m
//  TShow特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/6.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//
#define Frame [UIScreen mainScreen].bounds

#import "TSCircleViewController.h"
#import "TSActivetyVC.h"
#import "TSNearViewController.h"

#import "MapViewController.h"

@interface TSCircleViewController ()<CLLocationManagerDelegate>
{
    TSActivetyVC * viewControl;
    TSNearViewController * nearVC;
    CLLocationManager* locationManager;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIImageView *loactionImg;
@property (weak, nonatomic) IBOutlet UIButton *CityBtn;

//@property (weak, nonatomic) CLLocationManager* locationManager;

@end

@implementation TSCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self clickSegment:self.segment];
    
//    CLLocationManager* locationManager = [[CLLocationManager alloc] init];
    locationManager = [[CLLocationManager alloc] init];
//    self.locationManager = locationManager;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 10.0f;
    [locationManager startUpdatingLocation];
}
//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [locationManager stopUpdatingLocation];
//    NSLog(@"location ok");
//    NSLog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(城市)  SubLocality(区)
//            TSLog(@"%@", [test objectForKey:@"State"]);
            [self.CityBtn setTitle:[test objectForKey:@"State"] forState:UIControlStateNormal];
        }
    }];
}
- (IBAction)tongzhi{
    TSLog(@"通知:");
}
- (IBAction)dingwei{
    TSLog(@"定位:");
    MapViewController * mapView = [[MapViewController alloc] init];
    mapView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mapView animated:YES];
    
}
//  保证父控制器只有一个子控制器  提高运行效率
- (IBAction)clickSegment:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        viewControl = [[TSActivetyVC  alloc] init];
        viewControl.view.frame = CGRectMake(0, 64, Frame.size.width, Frame.size.height-64-48);
        [self.view addSubview:viewControl.view];
        [self addChildViewController:viewControl];
        
        [nearVC.view removeFromSuperview];
        [nearVC removeFromParentViewController];
    }else{
        nearVC = [[TSNearViewController  alloc] init];
        nearVC.view.frame = CGRectMake(0, 64, Frame.size.width, Frame.size.height-64-48);
        [self.view addSubview:nearVC.view];
        [self addChildViewController:nearVC];
        
        [viewControl.view removeFromSuperview];
        [viewControl removeFromParentViewController];
    }
}

//  拖拽程度  以及 导航栏的隐藏
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}





@end
