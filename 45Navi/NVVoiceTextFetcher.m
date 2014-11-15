//
//  NVVoiceTextFetcher.m
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import "NVVoiceTextFetcher.h"

static NSString const* kAPIKey = @"avcrj0fwhua607t6";
static NSString const* kAPIEndpoind = @"https://api.voicetext.jp/v1/tts";

@implementation NVVoiceTextFetcher

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

+ (NSString *)apiEndPoint
{
    return @"";
}

@end
