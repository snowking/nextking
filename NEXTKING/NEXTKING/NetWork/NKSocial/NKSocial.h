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



extern NSString *const NKSocialServiceTypeSinaWeibo;


@interface NKSocial : NSObject <SinaWeiboDelegate, SinaWeiboRequestDelegate> {
    
    SinaWeibo *sinaWeibo;
    
}

@property (nonatomic, retain) SinaWeibo *sinaWeibo;


+(id)social;

-(SinaWeibo*)initSinaWeiboWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecrect
              appRedirectURI:(NSString *)appRedirectURI
                 andDelegate:(id<SinaWeiboDelegate>)delegate;

-(void)loginWithSinaWeibo;




@end
