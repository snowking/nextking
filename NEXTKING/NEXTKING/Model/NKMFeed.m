//
//  NKMFeed.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKMFeed.h"

@implementation NKMFeed

@synthesize parentID;

-(void)dealloc{
    
    [parentID release];
    [super dealloc];
}


static NKMFeed *_cachedFeed = nil;

+(id)cachedFeed{
    
    if (!_cachedFeed) {
        _cachedFeed = [[self alloc] init];
    
        NKMAttachment *newAtt = [[NKMAttachment alloc] init];
        NSArray *attachments = [NSArray arrayWithObject:newAtt];
        [newAtt release];
        _cachedFeed.attachments = attachments;
        
    }
    return _cachedFeed;
    
}
+(void)resetCachedFeed{
    
    [[_cachedFeed.attachments lastObject] setPicture:nil];
    _cachedFeed.content = @"";
    _cachedFeed.parentID = nil;
    
}

+(void)cleanCachedFeed{
    
    [_cachedFeed release];
    _cachedFeed = nil;
}


@end
