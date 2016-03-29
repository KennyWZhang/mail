//
//  APIClient.m
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "APIClient.h"
#import "InVisionJSONResponseSerializer.h"

#define BASE_URL @"https://www.dropbox.com/"

@implementation APIClient

+ (APIClient *)sharedInstance {
    static APIClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    
    return instance;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [InVisionJSONResponseSerializer serializer];
        
        // For demo purposes, JSON file containing `messages` is "hosted" on Dropbox which doesn't use `application/json` in `Content-Type` header
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    
    return self;
}

@end
