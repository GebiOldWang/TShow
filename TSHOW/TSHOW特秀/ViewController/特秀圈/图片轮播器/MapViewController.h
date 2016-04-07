//
//  MapViewController.h
//  TSHOW特秀
//
//  Created by 上海银来（集团）有限公司 on 16/1/13.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface MapViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService* _locService;
}

@end
