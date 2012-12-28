//
//  NKSDK.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKSDK.h"

NSUInteger const kDefaultMaxConcurrentOperationCount = 8;

@implementation NKSDK

@synthesize requestQueue;



#pragma mark - Init and Dealloc

-(void)dealloc{
    
    [requestQueue release];
    
    [super dealloc];
}


static NKSDK *_sharedSDK = nil;
+(NKSDK*)sharedSDK{
    @synchronized(self) {
        
        if (!_sharedSDK) {
            _sharedSDK = [[self alloc] init];
        }
    }
    
    return  _sharedSDK;
}


-(id)init{
    self = [super init];
    if (self) {
        // Download Cache;
        [[ASIDownloadCache sharedCache] setDefaultCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
        [[ASIDownloadCache sharedCache] setShouldRespectCacheControlHeaders:NO];
        
        self.requestQueue = [[[ASINetworkQueue alloc] init] autorelease];
        self.requestQueue.maxConcurrentOperationCount = kDefaultMaxConcurrentOperationCount;
        
        
        
    }
    return self;
}


-(void)addRequest:(NKRequest*)request{
    
    //[ASIHTTPRequest setDefaultUserAgentString:@"kingiphone"];
    
    [self.requestQueue addOperation:request];
    [self.requestQueue go];
    
}


@end
