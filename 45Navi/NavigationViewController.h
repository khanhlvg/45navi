//
//  NavigationViewController.h
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class NVPlaceEntity;

@interface NavigationViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic) NVPlaceEntity *entity;

- (void)setupWithEntity:(NVPlaceEntity *)entity;

@end
