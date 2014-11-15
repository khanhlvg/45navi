//
//  NVWikipediaFetcher.m
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import "NVWikipediaListFetcher.h"
#import <CoreLocation/CoreLocation.h>
#import "NVPlaceEntity.h"
#import <AFNetworking.h>

@interface NVWikipediaListFetcher ()

@property (nonatomic) CLLocation *myLocation;

@end

@implementation NVWikipediaListFetcher

@synthesize placeEntity;

- (instancetype)initWithLocation:(CLLocation *)location
{
    self = [super init];
    
    if (self) {
        self.myLocation = location;
    }
    
    return self;
    
}

- (void)startFetchingWithCompletionHandler:(void (^)(NVPlaceEntity *result))completionHandler;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:[self.class urlForWikipediaAPIWithCentre:self.myLocation] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responeDict = responseObject;
        NSLog(@"%@", responeDict);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

+ (NSString *)urlForWikipediaAPIWithCentre:(CLLocation *)centreLocation
{
    NSString *baseURL = @"http://ja.wikipedia.org/w/api.php?action=query&format=json&colimit=max&prop=pageimages|coordinates&pithumbsize=150&pilimit=50&generator=geosearch&ggsradius=1000&ggsnamespace=0&ggslimit=50";
    
    NSString *location = [NSString stringWithFormat:@"&ggscoord=%f|%f",
                          centreLocation.coordinate.latitude,
                          centreLocation.coordinate.longitude];
    
    return [NSString stringWithFormat:@"%@%@",baseURL,location];
}

@end
