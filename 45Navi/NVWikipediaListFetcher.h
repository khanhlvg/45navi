//
//  NVWikipediaFetcher.h
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVPlaceEntity.h"
@class CLLocation;

@interface NVWikipediaListFetcher : NSObject

@property (nonatomic,readonly) NVPlaceEntity *placeEntity;

- (instancetype)initWithLocation:(CLLocation *)location;

- (void)startFetchingWithCompletionHandler:(void (^)(NSArray *result))completionHandler;

@end
