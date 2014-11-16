//
//  NVLocationManager.m
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import "NVLocationManager.h"

@interface NVLocationManager ()

@property (nonatomic) CLLocationManager *manager;

@end

@implementation NVLocationManager {
    CLLocation* _currentLocation;
}

@synthesize currentLocation=_currentLocation;

+ (instancetype) sharedInstance
{
    static NVLocationManager *shareInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.manager = [[CLLocationManager alloc] init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.manager requestWhenInUseAuthorization];
        [self.manager startUpdatingLocation];
        
        _currentLocation = [[CLLocation alloc] initWithLatitude:35.619932 longitude:139.7814267];
    }
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _currentLocation = ((CLLocation*) [locations lastObject]);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@" LocationManager failed ....");
    _currentLocation = [[CLLocation alloc] initWithLatitude:35.619932 longitude:139.7814267];
}

@end
