//
//  NKSocial.h
//  ZUO
//
//  Created by King on 12/29/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"
#import "NKRequest.h"



extern NSString *const NKSocialServiceTypeSinaWeibo;


@interface NKSocial : NSObject <SinaWeiboDelegate, SinaWeiboRequestDelegate> {
    
    SinaWeibo *sinaWeibo;
    
    NKRequestDelegate *loginRD;
    
}

@property (nonatomic, retain) SinaWeibo *sinaWeibo;

@property (nonatomic, assign) NKRequestDelegate *loginRD;


+(id)social;

-(SinaWeibo*)initSinaWeiboWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecrect
              appRedirectURI:(NSString *)appRedirectURI
                 andDelegate:(id<SinaWeiboDelegate>)delegate;

-(void)loginWithSinaWeiboWithRequestDelegate:(NKRequestDelegate*)rd;




@end