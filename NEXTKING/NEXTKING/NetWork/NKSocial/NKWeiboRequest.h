//
//  NKWeiboRequest.h
//  ZUO
//
//  Created by King on 1/6/13.
//  Copyright (c) 2013 King. All rights reserved.
//

#import "SinaWeiboRequest.h"

#import "NKRequest.h"

@interface NKWeiboRequest : SinaWeiboRequest <SinaWeiboRequestDelegate>{
    
    NKRequestDelegate   *requestDelegate;
    
}

@property (nonatomic, retain) NKRequestDelegate   *requestDelegate;


+ (id)requestWithURL:(NSString *)url
                          httpMethod:(NSString *)httpMethod
                              params:(NSDictionary *)params
                     requestDelegate:(NKRequestDelegate*)rd;

@end
