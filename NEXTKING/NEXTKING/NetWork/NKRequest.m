//
//  NKRequest.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKRequest.h"
#import "NKModel.h"
#import "NKConfig.h"


NSString *const NKRequestErrorNotification = @"NKRequestErrorNotification";

@interface NKRequest (Private)

-(id)mapDic:(NSDictionary*)dic toClass:(Class)tc;

@end


@implementation NKRequest

@synthesize requestDelegate;
@synthesize resultClass;
@synthesize resultType;
@synthesize resultKey;
@synthesize errorCode;
@synthesize results;
@synthesize originDic;

-(void)dealloc{
    
    
    [requestDelegate release];
    [resultKey release];
    
    [errorCode release];
    [results release];
    [originDic release];
    
    [super dealloc];
}



-(void)setCachePath:(NSString*)path shouldLoadFromWeb:(BOOL)shouldLoad{
    [self setDownloadCache:[ASIDownloadCache sharedCache]];
    [self setCachePolicy:shouldLoad?ASIDoNotReadFromCacheCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
    [self setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [self setDownloadDestinationPath:path];
}

// Default Post Method

// Get

+(id)getRequestWithURL:(NSURL*)newURL requestDelegate:(NKRequestDelegate*)rd resultClass:(Class)rc resultType:(NKResultType)type andResultKey:(NSString*)key{
    NKRequest *newRequest = [self requestWithURL:newURL requestDelegate:rd resultClass:rc resultType:type andResultKey:key];
    [newRequest setRequestMethod:@"GET"];
    return newRequest;
}


// Post
+(id)postRequestWithURL:(NSURL*)newURL requestDelegate:(NKRequestDelegate*)rd resultClass:(Class)rc resultType:(NKResultType)type andResultKey:(NSString*)key{
    return [self requestWithURL:newURL requestDelegate:rd resultClass:rc resultType:type andResultKey:key];
}

+(id)requestWithURL:(NSURL *)newURL requestDelegate:(NKRequestDelegate*)rd resultClass:(Class)rc resultType:(NKResultType)type andResultKey:(NSString*)key{
    NKRequest *newRequest = [super requestWithURL:newURL];
    newRequest.requestDelegate = rd;
    newRequest.resultClass = rc;
    newRequest.resultType = type;
    newRequest.resultKey = key;
    [newRequest setDelegate:newRequest];
    [newRequest setDidFinishSelector:@selector(requestFinish:)];
    [newRequest setDidFailSelector:@selector(requestFailed:)];
    return newRequest;
}


-(id)mapDic:(NSDictionary*)dic toClass:(Class)tc{
    
    return [tc modelFromDic:dic];
    
}

-(void)reportErrorWithObject:(id)someError{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NKRequestErrorNotification object:someError];
    
    [requestDelegate delegateFailedWithRequest:self];
}

-(void)requestFailed:(ASIHTTPRequest*)incomingrequest{
    
    self.errorCode = @900000;
    [self reportErrorWithObject:self.errorCode];
}

-(void)requestFinish:(ASIHTTPRequest*)incomingrequest{
    
    // JSON Parse
    NSError *tlocalError = nil;
    
    id parsedResult = nil;
    
    if ([incomingrequest downloadDestinationPath]) {
        parsedResult = [[NSData dataWithContentsOfFile:[incomingrequest downloadDestinationPath]] objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&tlocalError];
    }
    else {
        parsedResult = [[incomingrequest responseData] objectFromJSONDataWithParseOptions:JKParseOptionStrict error:&tlocalError];
    }
    
    //    NSLog(@"ResponseBody:\n%@", [[[NSString alloc] initWithData:[incomingrequest responseData] encoding:NSUTF8StringEncoding] autorelease]);
    
    //NSLog(@"%@", incomingrequest.responseString);
    
    //NSLog(@"%@", [incomingrequest responseCookies]);
    NSLog(@"---------------parsedResult-------------------:%@", parsedResult);
    
    if (tlocalError) {
        self.errorCode = @900002;
        [self reportErrorWithObject:self.errorCode];
    }
    else {
        // Success
        
        NSNumber *tServerError = [[NKConfig sharedConfig] parseDataKey] ? [parsedResult objectOrNilForKey:[[NKConfig sharedConfig] parseStatusKey]] : [NSNumber numberWithInt:1];
        
        if ((incomingrequest.responseStatusCode == 200 || incomingrequest.responseStatusCode == 304) && [tServerError intValue]==[[NKConfig sharedConfig] successReturnValue]) {
            
            
            id realSomething =  [[NKConfig sharedConfig] parseDataKey] ? [parsedResult objectOrNilForKey:[[NKConfig sharedConfig] parseDataKey]] : parsedResult;
            
            NSMutableArray *resultsArray = nil;
            
            switch (self.resultType) {
                case NKResultTypeSingleObject:{
                    resultsArray = [NSArray arrayWithObject:[self mapDic:realSomething toClass:self.resultClass]];
                }
                    break;
                case NKResultTypeArray:{
                    
                    NSArray *values = realSomething;
                    
                    resultsArray = [NSMutableArray arrayWithCapacity:[values count]];
                    for (NSDictionary *dic in values) {
                        [resultsArray addObject:[self mapDic:dic toClass:self.resultClass]];
                    }
                    
                }
                    break;
                case NKResultTypeDeapArray:{
                    
                    
                    resultsArray = [NSMutableArray arrayWithCapacity:[realSomething count]];
                    for (NSArray *array in realSomething) {
                        
                        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:[array count]];
                        for (NSDictionary *dic in array) {
                            [tempArray addObject:[self mapDic:dic toClass:self.resultClass]];
                        }
                        [resultsArray addObject:tempArray];
                        
                    }
                    
                }
                    break;
                case NKResultTypeResultSets:{
                    NSArray *values = [realSomething objectOrNilForKey:@"values"];
                    
                    resultsArray = [NSMutableArray arrayWithCapacity:[values count]];
                    for (NSDictionary *dic in values) {
                        [resultsArray addObject:[self mapDic:dic toClass:self.resultClass]];
                    }
                    
                }
                    break;
                case NKResultTypeOrigin:{
                    self.originDic = parsedResult;
                }
                    break;
                case NKResultTypeOriginArray:{
                    
                    resultsArray = [NSMutableArray arrayWithCapacity:[realSomething count]];
                    for (NSDictionary *dic in realSomething) {
                        [resultsArray addObject:[self mapDic:dic toClass:self.resultClass]];
                    }
                    
                }
                    
                default:
                    break;
            }
            
            self.results = resultsArray;
            [requestDelegate delegateFinishWithRequest:self];
            
        }// Error
        else {
            
            self.errorCode = tServerError;
            [self reportErrorWithObject:self.errorCode];
            
        }
        
    }
}


// A new ticket to Redo the task
-(id)copyWithZone:(NSZone *)zone{
    
    NKRequest *newRequest = [super copyWithZone:nil];
    newRequest.requestDelegate = self.requestDelegate;
    newRequest.resultClass = self.resultClass;
    newRequest.resultKey = self.resultKey;
    newRequest.resultType = self.resultType;
    return newRequest;
}

-(void)startNK{
    [requestDelegate delegateStartWithRequest:self];
    [self startAsynchronous];
}
-(void)cancelNK{
    [self clearDelegatesAndCancel];
}

@end