//
//  NVPlaceEntity.m
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import "NVPlaceEntity.h"
#import <MapKit/MapKit.h>

@implementation NVPlaceEntity

- (NSString *)transitString
{
    NSString *transitTypeStr;
    
    switch (self.transitType) {
        case NVTransitTypeByFoot:
            transitTypeStr = @"徒歩";
            break;
            
        case NVTransitTypeByTrain:
            transitTypeStr = @"電車で";
            break;
            
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@ %zd分",transitTypeStr,self.transitTime];
}

- (NSInteger)transitTime
{
    if (self.route) {
        return self.route.expectedTravelTime / 60;
    }
    
    return 1000;
}

- (NVTransitType)transitType
{
    if (self.route) {
        for (MKRouteStep *step in self.route.steps) {
            //NSLog(@"transportType = %@",step.instructions);
            if (step.transportType != MKDirectionsTransportTypeWalking) {
                return NVTransitTypeByTrain;
            }
        }
    }
    
    return NVTransitTypeByFoot;
}

@end
