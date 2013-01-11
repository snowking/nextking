//
//  NKServiceBase.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NKRequest.h"
#import "NKModelDefine.h"
#import "NSURL+StringURLEncode.h"


#define $shared(Klass) [Klass shared##Klass]

#define dshared(Klass) +(id)shared##Klass

#define $singleton(Klass)\
\
static Klass *shared##Klass = nil;\
\
+ (Klass *)shared##Klass {\
@synchronized(self) {\
if(shared##Klass == nil) {\
shared##Klass = [[self alloc] init];\
}\
}\
return shared##Klass;\
}



#define $singleService(Klass, serviceName)\
\
static Klass *shared##Klass = nil;\
\
+ (Klass *)shared##Klass {\
@synchronized(self) {\
if(shared##Klass == nil) {\
shared##Klass = [[self alloc] init];\
[shared##Klass setServiceName:serviceName];\
}\
}\
return shared##Klass;\
}



@interface NKServiceBase : NSObject{
    
    NSString *serviceName;
}
@property (nonatomic,retain) NSString *serviceName;

-(void)addRequest:(NKRequest*)request;
-(NSString *)serviceBaseURL;

-(NSString*)makeMD5:(NSString*)string;

@end
