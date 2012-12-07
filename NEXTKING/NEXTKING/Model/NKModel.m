//
//  NKModel.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKModel.h"
#import "NKMAccount.h"
#import "NKMFeed.h"




@implementation NKModel

@synthesize jsonDic;
@synthesize mid;

-(void)dealloc{
    
    [mid release];
    [jsonDic release];
    [super dealloc];
}


+(id)modelFromDic:(NSDictionary*)dic{
    
    NKModel *newModel = [[self alloc] init];
    newModel.jsonDic = dic;
    newModel.mid = [NSString stringWithFormat:@"%@", [dic objectOrNilForKey:@"id"]];
    return [newModel autorelease];
    
}

-(NSDictionary*)cacheDic{
    return self.jsonDic;
}

+(id)modelFromCache:(NSDictionary*)cache{
    return [self modelFromDic:cache];
}

@end


@implementation NSDictionary (ForJsonNull)

- (id)objectOrNilForKey:(id)key {
    id object = [self objectForKey:key];
    if(object == [NSNull null]) {
        return nil;
    }
    return object;
}

@end

@implementation NSMutableDictionary (SetNilForKey)

- (void)setObjectOrNil:(id)object forKey:(id)key {
    if(!object) {
        [self removeObjectForKey:key];
        return;
    }
    [self setObject:object forKey:key];
}

@end


@implementation NKMemoryCache

@synthesize cachedUsers;




-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NKWillLogoutNotificationKey object:nil];
    [cachedUsers release];

    [super dealloc];
    
}
static NKMemoryCache *_sharedMemoryCache = nil;

+(id)sharedMemoryCache{
    
    if (!_sharedMemoryCache) {
        @synchronized(self){
            _sharedMemoryCache = [[self alloc] init];
        }
    }
    
    return _sharedMemoryCache;
}

-(void)logout:(NSNotification*)noti{
    [self.cachedUsers removeAllObjects];
    [NKMUser meFromUser:nil];
    [NKMFeed resetCachedFeed];
    
}
-(id)init{
    self = [super init];
    if (self) {
        self.cachedUsers = [NSMutableDictionary dictionary];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout:) name:NKWillLogoutNotificationKey object:nil];
        
    }
    return self;
}

@end