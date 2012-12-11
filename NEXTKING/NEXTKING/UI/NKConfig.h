//
//  NKConfig.h
//  iSou
//
//  Created by King on 12-11-8.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKConfig : NSObject{
    
    
    CGFloat navigatorHeight;
    BOOL    navigatorChangeAnimate;
    BOOL    navigatorShowAnimate;
    
    NSString *domainURL;
    
    NSString *parseDataKey;
    
    int successReturnValue;
    
    id errorTarget;
    SEL errorMethod;
    
}

@property (nonatomic, assign) CGFloat navigatorHeight;
@property (nonatomic, assign) BOOL    navigatorChangeAnimate;
@property (nonatomic, assign) BOOL    navigatorShowAnimate;

@property (nonatomic, retain) NSString *domainURL;
@property (nonatomic, retain) NSString *parseDataKey;
@property (nonatomic, retain) NSString *parseStatusKey;
@property (nonatomic, assign) int successReturnValue;

@property (nonatomic, assign) id  errorTarget;
@property (nonatomic, assign) SEL errorMethod;

+(id)sharedConfig;


@end
