//
//  NKImageLoader.m
//  iSou
//
//  Created by King on 12-12-6.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import "NKImageLoader.h"
#import "NKModel.h"

@implementation  ASIHTTPRequest (ImageDownload)

+(id)requestWithImageURL:(NSURL *)newURL{
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:newURL usingCache:[ASIDownloadCache sharedCache] andCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [request setDownloadDestinationPath:
     [[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
    NSLog(@"DownLoad Image:%@", [request url]);
    
    return request;
    
}

@end

@implementation NKImageLoadObject

@synthesize object;
@synthesize url;
@synthesize keyPath;

@synthesize image;

-(void)dealloc{
    
    [object release];
    [url release];
    [keyPath release];
    
    [image release];
    
    [super dealloc];
}


+(id)imageLoadObjectWithObject:(id)theObject url:(NSString*)imageURL andKeyPath:(NSString*)path{
    
    NKImageLoadObject *imageLoadObject = [[self alloc] init];
    
    imageLoadObject.object = theObject;
    imageLoadObject.url = imageURL;
    imageLoadObject.keyPath = path;
    
    return [imageLoadObject autorelease];
}


-(UIImage*)image{
    
    if (!image) {
        
        NKImageLoadObject *loadObject = [NKImageLoadObject imageLoadObjectWithObject:self url:self.url andKeyPath:@"image"];
        [[NKImageLoader imageLoader] addImageLoadObject:loadObject];
    }
    
    
    
    return image;
}


@end



@implementation NKImageLoader

@synthesize imageLoadObjects;

-(void)dealloc{
    
    [imageLoadObjects release];
    [super dealloc];
}

static NKImageLoader *_imageLoader = nil;
+(id)imageLoader{
    
    if (!_imageLoader) {
        _imageLoader = [[self alloc] init];
    }
    return _imageLoader;
}


-(id)init{
    
    self = [super init];
    if (self) {
        self.imageLoadObjects = [NSMutableArray array];
    }
    
    return self;
}

-(ASIHTTPRequest*)addImageLoadObject:(NKImageLoadObject*)imageLoadObject{
    
    
    NSArray *array = [self.imageLoadObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(url = %@) AND (keyPath = %@)", imageLoadObject.url, imageLoadObject.keyPath]];
    
    for (NKImageLoadObject *loadObj in array) {
        if (loadObj.object == imageLoadObject.object) {
            return nil;
        }
    }
    
    [self.imageLoadObjects addObject:imageLoadObject];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithImageURL:[NSURL URLWithString:imageLoadObject.url]];
    request.userInfo = [NSDictionary dictionaryWithObject:imageLoadObject forKey:@"object"];
    request.delegate = self;
    [request setDidFinishSelector:@selector(downloadOK:)];
    [request setDidFailSelector:@selector(downloadFailed:)];
    [request startAsynchronous];
    
    return request;

}

-(void)downloadOK:(ASIHTTPRequest*)request{
    
    
    
    dispatch_queue_t concurrentQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        
        __block UIImage *picImage = nil;
        NKImageLoadObject *imageLoadObject = [request.userInfo objectForKey:@"object"];
        dispatch_sync(concurrentQueue, ^{
            picImage = [UIImage imageWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
            
        });
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (picImage) {
                [imageLoadObject.object setValue:picImage forKey:imageLoadObject.keyPath];
            }
            
            [self.imageLoadObjects removeObject:imageLoadObject];
        });
    });
    
}


-(void)downloadFailed:(ASIHTTPRequest*)request{
    
    [self downloadOK:request];
}

@end
