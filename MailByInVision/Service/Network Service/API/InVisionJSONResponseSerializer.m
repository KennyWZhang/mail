//
//  InVisionJSONResponseSerializer.m
//  MailByInVision
//
//  Created by Michal Kalis on 21/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "InVisionJSONResponseSerializer.h"

@implementation InVisionJSONResponseSerializer

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error {
    NSError *errorFromSuperclass = nil;
    id responseObject = [super responseObjectForResponse:response data:data error:&errorFromSuperclass];
    
    // Global handling of network errors
    if (errorFromSuperclass) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *message = @"Communication with server failed.";
            
            switch (errorFromSuperclass.code) {
                case NSURLErrorTimedOut:
                    message = @"Connection timed out.";
                    break;
                case NSURLErrorCancelled:
                    // No action when request is cancelled by user
                    return;
                    
                default:
                    break;
            }
            
            *error = errorFromSuperclass;
            
            [[[UIAlertView alloc] initWithTitle:@"Communcation Error" message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil] show];
        });
    }
    
    return responseObject;
}

@end
