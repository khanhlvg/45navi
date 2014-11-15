//
//  NVVoiceTextFetcher.h
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVVoiceTextFetcher : NSObject

- (instancetype)initWithText:(NSString *)text;
- (void)startFetchingWithCompletionHandler:(void (^)(NSData *wavData))completionHandler;

@end
