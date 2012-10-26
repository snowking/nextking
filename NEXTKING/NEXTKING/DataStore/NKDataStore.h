//
//  NKDataStore.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKMAccount.h"

extern NSString *const NKCachePathProfile;

@interface NKDataStore : NSObject{
    
    
}


+(id)sharedDataStore;

-(NSString*)rootPath;
-(NSString*)accountsPath;

-(NSString*)cachedPathOf:(NSString*)cacheKey forAccount:(NKMAccount*)account;
-(NSString*)cachedPathOf:(NSString*)cacheKey;

-(NSMutableArray *)cachedArrayOf:(NSString*)cacheKey andClass:(Class)cc;
-(id)cachedObjectOf:(NSString*)cacheKey andClass:(Class)cc;

-(BOOL)cacheArray:(NSArray*)array forCacheKey:(NSString*)cacheKey;
-(BOOL)cacheObject:(id)object forCacheKey:(NSString*)cacheKey;

@end
