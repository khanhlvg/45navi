//
//  NVEventDataFetcher.h
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/16/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface NVEventDataFetcher : NSObject

- (instancetype)initWithLocation:(CLLocation *)location;

- (void)startFetchingWithCompletionHandler:(void (^)(NSArray *result))completionHandler;

@end
