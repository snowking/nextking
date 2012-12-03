//
//  NKRequest.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import "JSONKit.h"
#import "NKRequestDelegate.h"
#import "ASIDownloadCache.h"

typedef enum{
	NKResultTypeSingleObject,   // Single Object
	NKResultTypeArray,          // Array of objects with in sb dic
    NKResultTypeResultSets,     // totalCount and array of some objects
    NKResultTypeOriginArray,
    NKResultTypeDeapArray,    // [[a,a,a],[a,a],[a,a]]
    NKResultTypeOrigin
}NKResultType;

extern NSString *const NKRequestErrorNotification;


@interface NKRequest : ASIFormDataRequest{
    
    NKRequestDelegate   *requestDelegate;
    Class                resultClass;
    NKResultType         resultType;
    NSString            *resultKey;
    

    NSNumber            *errorCode;
    NSArray             *results;
    NSDictionary        *originDic;
    
}

@property (nonatomic, retain) NKRequestDelegate  *requestDelegate;
@property (nonatomic, assign) Class               resultClass;
@property (nonatomic, assign) NKResultType        resultType;
@property (nonatomic, retain) NSString           *resultKey;

@property (nonatomic, retain) NSNumber           *errorCode;
@property (nonatomic, retain) NSArray            *results;
@property (nonatomic, retain) NSDictionary       *originDic;



-(void)setCachePath:(NSString*)path shouldLoadFromWeb:(BOOL)shouldLoad;

// Default Post Method

// Get
+(id)getRequestWithURL:(NSURL*)newURL requestDelegate:(NKRequestDelegate*)rd resultClass:(Class)rc resultType:(NKResultType)type andResultKey:(NSString*)key;

// Post
+(id)postRequestWithURL:(NSURL*)newURL requestDelegate:(NKRequestDelegate*)rd resultClass:(Class)rc resultType:(NKResultType)type  andResultKey:(NSString*)key;


-(void)startNK;
-(void)cancelNK;




@end
