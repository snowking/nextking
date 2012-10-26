//
//  NKModel.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h> // Necessary for background task support
#endif


#import "JSONKit.h"
#import "NSURL+StringURLEncode.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

#define NKBindValueForParameter(value, param) \
if(value!=nil) {\
param = value;\
}\


#define NKBindValueWithKeyForParameterFromDic(key, param, dic) \
if([dic objectOrNilForKey:key]!=nil) {\
param = [dic objectOrNilForKey:key];\
}\

#define NKBindValueWithKeyForParameterFromCache(key, param, dic) \
if(!param) {\
param = [dic objectOrNilForKey:key];\
}\


#define NKBindValueToKeyForParameterToDic(key, param, dic) \
if(param != nil) {\
[dic setObject:param forKey:key];\
}\



@interface ASIHTTPRequest (ImageDownload)

+(id)requestWithImageURL:(NSURL *)newURL;

@end


@interface NKModel : NSObject{

    NSDictionary *jsonDic;
    NSString     *mid; // model id
    
}

@property (nonatomic, retain) NSDictionary *jsonDic;
@property (nonatomic, retain) NSString     *mid;

+(id)modelFromDic:(NSDictionary*)dic;
-(NSDictionary*)cacheDic;
+(id)modelFromCache:(NSDictionary*)cache;


@end

@interface NKMemoryCache : NSObject {
    NSMutableDictionary *cachedUsers;

}
@property (nonatomic, retain) NSMutableDictionary *cachedUsers;

+(id)sharedMemoryCache;


@end


@interface NSDictionary (ForJsonNull)

- (id)objectOrNilForKey:(id)key;

@end

@interface NSMutableDictionary (SetNilForKey)

- (void)setObjectOrNil:(id)object forKey:(id)key;

@end

