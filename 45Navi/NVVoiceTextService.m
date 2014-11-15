//
//  NVVoiceTextService.m
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import "NVVoiceTextService.h"
#import <AVFoundation/AVFoundation.h>
#import "NVVoiceTextFetcher.h"

@interface NVVoiceTextService ()

@property (nonatomic) AVAudioPlayer* player;

@end

@implementation NVVoiceTextService

+ (instancetype)sharedInstance
{
    static id sharedInstace;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstace = [[self alloc] init];
    });
    
    return sharedInstace;
}

- (void)readText:(NSString *)text
{
    NVVoiceTextFetcher *fetcher = [[NVVoiceTextFetcher alloc] initWithText:text];
    [fetcher startFetchingWithCompletionHandler:^(NSData *wavData) {
        NSError *error = nil;
        self.player = [[AVAudioPlayer alloc] initWithData:wavData error:&error];
        [self.player play];
    }];
}

@end
