//
//  NVVoiceTextFetcher.m
//  45Navi
//
//  Created by Tran Thanh Thuy on 11/15/14.
//  Copyright (c) 2014 45Navi Team. All rights reserved.
//

#import "NVVoiceTextFetcher.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking.h>

static NSString* const kAPIKey = @"avcrj0fwhua607t6";
static NSString* const kAPIEndpoint = @"https://api.voicetext.jp/v1/tts";

@interface NVVoiceTextFetcher ()

@property (nonatomic,copy) NSString *textToSpeak;

@end

@implementation NVVoiceTextFetcher {

}

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    
    if (self) {
        self.textToSpeak = text;
    }
    
    return self;
}

- (void)startFetchingWithCompletionHandler:(void (^)(NSData *wavData))completionHandler;
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"text": self.textToSpeak,
                                 @"speaker": @"haruka",
                                 @"emotion" : @"happiness",
                                 @"emotion_level" : @"2"};
    
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:kAPIKey password:@""];
    
    AFHTTPRequestOperation *operation = [manager POST:kAPIEndpoint parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *wavData =responseObject;
        
        completionHandler(wavData);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"audio/wav"];
}

@end
