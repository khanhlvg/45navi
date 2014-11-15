//
//  NVLocationManager.h
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NVLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic,readonly) CLLocation *currentLocation;

@end
