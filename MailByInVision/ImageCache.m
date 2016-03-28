//
//  ImageCache.m
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

#import "ImageCache.h"
#import "NSString+Crypto.h"

@implementation ImageCache

+ (ImageCache *)defaultCache {
    static ImageCache *inst;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [[ImageCache alloc] init];
    });
    return inst;
}

- (id)init {
    if (self = [super init]) {
        _imageDownloadQueue = [[NSOperationQueue alloc] init];
        _imageDownloadQueue.name = @"image download queue";
    }
    return self;
}

- (UIImage *)imageCachedFromURL:(NSURL *)URL {
    
    UIImage *cachedImage = [self objectForKey:URL.absoluteString.MD5];
#ifdef DEBUG
    if (cachedImage != nil) {
        NSLog(@"Getting image from cache for URL %@", URL.absoluteString);
    }
#endif
    
    // Download if not present, download is blocking here
    if (cachedImage == nil) {
        NSData *imageData = [NSData dataWithContentsOfURL:URL];
        cachedImage = [UIImage imageWithData:imageData];
        
        if (cachedImage) {
            [self addImage:cachedImage withURL:URL];
        }
    }
    
    return cachedImage;
}

- (void)addImage:(UIImage *)image withURL:(NSURL *)URL {
#ifdef DEBUG
    NSLog(@"Adding image to cache from URL %@", URL.absoluteString);
#endif
    [self setObject:image forKey:URL.absoluteString.MD5];
}

@end
