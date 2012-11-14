//
//  NKDataStore.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKDataStore.h"
#import "NKAccountManager.h"

NSString *const NKCachePathProfile = @"NKCachePathProfile.NK";

@implementation NKDataStore


-(void)dealloc{
    
    
    
    [super dealloc];
}

static NKDataStore *_sharedDataStore = nil;

+(id)sharedDataStore{
    if (!_sharedDataStore) {
        @synchronized(self){
            _sharedDataStore = [[NKDataStore alloc] init];
        }
    }
    
    return _sharedDataStore;
}

#pragma mark Methods

-(NSString*)rootPath{
    
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

-(NSString*)accountsPath{
    
    NSLog(@"%@", [[self rootPath] stringByAppendingPathComponent:@"NKAccountsPath.NK"]);
    
    return [[self rootPath] stringByAppendingPathComponent:@"NKAccountsPath.NK"];
}

-(NSString*)pathForAccount:(NKMAccount*)account{
    
    [[NSFileManager defaultManager] createDirectoryAtPath:[[self rootPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", account.mid]] withIntermediateDirectories:YES attributes:nil error:nil];
    
    return[[self rootPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", account.mid]];
}

-(NSString*)cachedPathOf:(NSString*)cacheKey forAccount:(NKMAccount*)account{
    
    //NSLog(@"%@", [[self pathForAccount:account] stringByAppendingPathComponent:cacheKey]);
    
    return [[self pathForAccount:account] stringByAppendingPathComponent:cacheKey];
    
}
-(NSString*)cachedPathOf:(NSString*)cacheKey{
    
    return [self cachedPathOf:cacheKey forAccount:[[NKAccountManager sharedAccountsManager] currentAccount]];
}


-(NSMutableArray*)cachedArray:(NSArray*)array withClass:(Class)cc{
    
    if ([array count]) {
        NSMutableArray *cachedArray = [NSMutableArray arrayWithCapacity:[array count]];
        for (id object in array) {
            
            if ([object isKindOfClass:[NSArray class]]) {
                [cachedArray addObject:[self cachedArray:object withClass:cc]];
            }
            else{
                [cachedArray addObject:[cc modelFromCache:object]];
            }
            
        }
        return cachedArray;
    }
    
    return nil;
    
}


-(NSMutableArray *)cachedArrayOf:(NSString*)cacheKey andClass:(Class)cc{
    
    NSMutableArray *cachedArray = [self cachedArray:[NSArray arrayWithContentsOfFile:[self cachedPathOf:cacheKey]] withClass:cc];
    
    if ([cachedArray count]) {
        return cachedArray;
    }
    return nil;
    
}
-(id)cachedObjectOf:(NSString*)cacheKey andClass:(Class)cc{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[self cachedPathOf:cacheKey]];
    
    if (dic) {
        if (cc && (cc != [NSDictionary class] || cc !=[NSMutableDictionary class])) {
            return [cc modelFromCache:dic];
        }
        else
            return dic;
        
    }
    return nil;
}


-(NSMutableArray*)arrayToCache:(NSArray*)array{
    
    NSMutableArray *arrayToCache = [NSMutableArray arrayWithCapacity:[array count]];
    
    for (id object in array) {
        
        if ([object isKindOfClass:[NSArray class]]) {
            [arrayToCache addObject:[self arrayToCache:object]];
        }
        else{
            [arrayToCache addObject:[object cacheDic]];
        }
        
    }
    
    return arrayToCache;
}

-(BOOL)cacheArray:(NSArray*)array forCacheKey:(NSString*)cacheKey{
    
    NSMutableArray *arrayToCache = [self arrayToCache:array];
    
    return [arrayToCache writeToFile:[self cachedPathOf:cacheKey] atomically:YES];
}
-(BOOL)cacheObject:(id)object forCacheKey:(NSString*)cacheKey{
    
    if ([object respondsToSelector:@selector(cacheDic)]) {
        return [[object cacheDic] writeToFile:[self cachedPathOf:cacheKey] atomically:YES];
    }
    else
        return [object writeToFile:[self cachedPathOf:cacheKey] atomically:YES];
    
}

@end