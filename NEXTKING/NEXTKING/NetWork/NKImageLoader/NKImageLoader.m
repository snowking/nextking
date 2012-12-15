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

-(void)addImageLoadObject:(NKImageLoadObject*)imageLoadObject{
    
    
    NSArray *array = [self.imageLoadObjects filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(url = %@) AND (keyPath = %@)", imageLoadObject.url, imageLoadObject.keyPath]];
    
    if ([array count]) {
        return;
    }
    
    
    [self.imageLoadObjects addObject:imageLoadObject];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithImageURL:[NSURL URLWithString:imageLoadObject.url]];
    request.userInfo = [NSDictionary dictionaryWithObject:imageLoadObject forKey:@"object"];
    request.delegate = self;
    [request setDidFinishSelector:@selector(downloadOK:)];
    [request setDidFailSelector:@selector(downloadFailed:)];
    [request startAsynchronous];

}

-(void)downloadOK:(ASIHTTPRequest*)request{
    
    NKImageLoadObject *imageLoadObject = [request.userInfo objectForKey:@"object"];
    
    UIImage *picImage = [UIImage imageWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
    if (picImage) {
        [imageLoadObject.object setValue:picImage forKey:imageLoadObject.keyPath];
    }
    
    [self.imageLoadObjects removeObject:imageLoadObject];
    
}


-(void)downloadFailed:(ASIHTTPRequest*)request{
    
    [self downloadOK:request];
}

@end
