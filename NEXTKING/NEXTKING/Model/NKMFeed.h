//
//  NKMFeed.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKMRecord.h"

@interface NKMFeed : NKMRecord


+(id)cachedFeed;
+(void)resetCachedFeed;
+(void)cleanCachedFeed;

@end
