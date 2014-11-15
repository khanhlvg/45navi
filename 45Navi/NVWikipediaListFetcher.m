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
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
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
            
            [resultList addObject:entity];
            NSLog(@"Title = %@", entity.placeName);
        }
        
        completionHandler([NSArray arrayWithArray:resultList]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionHandler(nil);
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

@end
