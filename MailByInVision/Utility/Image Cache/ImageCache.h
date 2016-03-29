//
//  ImageCache.h
//  MailByInVision
//
//  Created by Michal Kalis on 28/03/16.
//  Copyright © 2016 Michal Kalis. All rights reserved.
//

@import UIKit;

@interface ImageCache : NSCache

@property (nonatomic, strong) NSOperationQueue *imageDownloadQueue;

+ (ImageCache *)defaultCache;
- (UIImage *)imageCachedFromURL:(NSURL *)URL;
- (void)addImage:(UIImage *)image withURL:(NSURL *)URL;

@end
