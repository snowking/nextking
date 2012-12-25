//
//  NKImageLoader.h
//  iSou
//
//  Created by King on 12-12-6.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"


@interface ASIHTTPRequest (ImageDownload)

+(id)requestWithImageURL:(NSURL *)newURL;

@end


@interface NKImageLoadObject : NSObject{
    
    id object;
    NSString *url;
    NSString *keyPath;
    
    
    UIImage *image;
    
}
@property (nonatomic, retain) id        object;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *keyPath;

@property (nonatomic, retain) UIImage  *image;

+(id)imageLoadObjectWithObject:(id)theObject url:(NSString*)imageURL andKeyPath:(NSString*)path;

@end



@interface NKImageLoader : NSObject{
    
    NSMutableArray *imageLoadObjects;
    
}

@property (nonatomic, retain) NSMutableArray *imageLoadObjects;

+(id)imageLoader;

-(ASIHTTPRequest*)addImageLoadObject:(NKImageLoadObject*)imageLoadObject;

@end
