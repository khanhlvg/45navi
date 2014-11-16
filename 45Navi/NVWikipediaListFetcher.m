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
#import <MapKit/MapKit.h>
#import "NVLocationManager.h"
#import <AddressBook/AddressBook.h>

@interface NVWikipediaListFetcher ()

@property (nonatomic) CLLocation *myLocation;
@property (nonatomic,copy) void (^completionHandler)(NSArray *result);
@property (nonatomic) NSArray *resultList;
@property (nonatomic) NSUInteger remainingRouteFetchCount;

@end

static NSString *const kBaseURL = @"http://ja.wikipedia.org/w/api.php";

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

- (void)startFetchingWithCompletionHandler:(void (^)(NSArray *result))completionHandler
{
    self.completionHandler = completionHandler;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    __typeof__(self) __weak weakSelf = self;
    
    [manager GET:kBaseURL parameters:[self.class queryParameterWithCentreLocation:self.myLocation] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *resultList = [NSMutableArray new];
        
        NSDictionary *responeDict = responseObject;
        NSDictionary *pages = responeDict[@"query"][@"pages"];
        
        for (NSDictionary *item in pages.allValues) {
            NVPlaceEntity *entity = [[NVPlaceEntity alloc] init];
            entity.location = [[CLLocation alloc] initWithLatitude:[item[@"coordinates"][0][@"lat"] floatValue]
                                                         longitude:[item[@"coordinates"][0][@"lon"] floatValue]];
            entity.placeName = item[@"title"];
            
            entity.imageURL = item[@"thumbnail"][@"source"];
            
            [self processRouteForPlaceEntity:entity];
            
            [resultList addObject:entity];
//            NSLog(@"Title = %@", entity.placeName);
        }
        
        /*completionHandler([NSArray arrayWithArray:resultList]);*/
        weakSelf.resultList = resultList;
        [weakSelf startALLRouteFetcher];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionHandler(nil);
    }];
}

+ (NSDictionary *)queryParameterWithCentreLocation:(CLLocation *)centreLocation
{
    NSMutableDictionary *param = [NSMutableDictionary new];
    
    [param setObject:@"query" forKey:@"action"];
    [param setObject:@"json" forKey:@"format"];
    [param setObject:@"max" forKey:@"colimit"];
    [param setObject:@"pageimages|coordinates" forKey:@"prop"];
    [param setObject:@"150" forKey:@"pithumbsize"];
    [param setObject:@"50" forKey:@"pilimit"];
    [param setObject:@"geosearch" forKey:@"generator"];
    [param setObject:@"3000" forKey:@"ggsradius"];
    [param setObject:@"0" forKey:@"ggsnamespace"];
    [param setObject:@"50" forKey:@"ggslimit"];
    [param setObject:[NSString stringWithFormat:@"%f|%f",
                      centreLocation.coordinate.latitude,
                      centreLocation.coordinate.longitude] forKey:@"ggscoord"];
    //[param setObject:@"" forKey:@""];
    
    return [NSDictionary dictionaryWithDictionary:param];
}

- (NVPlaceEntity *)processRouteForPlaceEntity:(NVPlaceEntity *)entity
{
    // create origin
    NVLocationManager *locationManager = [NVLocationManager sharedInstance];
    
    CLLocationCoordinate2D currentCoords = locationManager.currentLocation.coordinate;
    
    NSDictionary *currentAddress = @{
                              (NSString *)kABPersonAddressStreetKey: @"現在地",
                              };
    
    MKPlacemark *currentPlace = [[MKPlacemark alloc]
                          initWithCoordinate:currentCoords addressDictionary:currentAddress];
    
    // create destination
    CLLocationCoordinate2D destCoords = entity.location.coordinate;
    
    NSDictionary *destAddress = @{
                                     (NSString *)kABPersonAddressStreetKey: entity.placeName,
                                     };
    
    MKPlacemark *destPlace = [[MKPlacemark alloc]
                                 initWithCoordinate:destCoords addressDictionary:destAddress];
    
    // create Map request
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    request.source = [[MKMapItem alloc] initWithPlacemark:currentPlace];
    request.destination = [[MKMapItem alloc] initWithPlacemark:destPlace];
    
    request.requestsAlternateRoutes = NO;
    
    // 直線距離が1.2km以上だと、電車などでの移動を優先するが、そうでなければ、徒歩を優先
    if ([locationManager.currentLocation distanceFromLocation:entity.location] > 1200) {
        request.transportType = MKDirectionsTransportTypeAny;
    } else {
        request.transportType = MKDirectionsTransportTypeWalking;
    }
    
    //__typeof__(self) __weak weakSelf = self;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle Error
         } else {
            entity.route = [response.routes lastObject];
            NSLog(@"%@ - %@",entity.placeName, entity.transitString);
         }
         
         [self finishONERouteFetcherAndConsiderCallCompletionHandler];
         
     }];
    return entity;
}

- (void)startALLRouteFetcher
{
    self.remainingRouteFetchCount = [self.resultList count];
}

- (void)finishONERouteFetcherAndConsiderCallCompletionHandler
{
    self.remainingRouteFetchCount--;
    
    if (self.remainingRouteFetchCount == 0) {
        if (self.completionHandler) {
            self.completionHandler([NSArray arrayWithArray:self.resultList]);
        }
    }
}

@end
