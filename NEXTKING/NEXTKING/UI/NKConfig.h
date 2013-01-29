//
//  NKConfig.h
//  iSou
//
//  Created by King on 12-11-8.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKAccountManager.h"

@interface NKConfig : NSObject{
    
    
    CGFloat navigatorHeight;
    BOOL    navigatorChangeAnimate;
    BOOL    navigatorShowAnimate;
    
    NSString *domainURL;
    
    NSString *parseDataKey;
    NSString *parseValueKey;
    
    int successReturnValue;
    
    id errorTarget;
    SEL errorMethod;
    
    NSString *storeURL;
    NSString *showVersion;
    
    id apnTarget;
    SEL apnMethod;
    
    
    Class accountManagerClass;
    
}

@property (nonatomic, assign) CGFloat navigatorHeight;
@property (nonatomic, assign) BOOL    navigatorChangeAnimate;
@property (nonatomic, assign) BOOL    navigatorShowAnimate;

@property (nonatomic, retain) NSString *domainURL;
@property (nonatomic, retain) NSString *parseDataKey;
@property (nonatomic, retain) NSString *parseStatusKey;
@property (nonatomic, retain) NSString *parseValueKey;
@property (nonatomic, assign) int successReturnValue;

@property (nonatomic, retain) NSString *storeURL;
@property (nonatomic, retain) NSString *showVersion;


@property (nonatomic, assign) id  errorTarget;
@property (nonatomic, assign) SEL errorMethod;

@property (nonatomic, assign) id  apnTarget;
@property (nonatomic, assign) SEL apnMethod;

@property (nonatomic, assign) Class accountManagerClass;

+(id)sharedConfig;


@end
