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
    
}

@property (nonatomic, assign) CGFloat navigatorHeight;
@property (nonatomic, assign) BOOL    navigatorChangeAnimate;
@property (nonatomic, assign) BOOL    navigatorShowAnimate;

@property (nonatomic, retain) NSString *domainURL;

+(id)sharedConfig;


@end
