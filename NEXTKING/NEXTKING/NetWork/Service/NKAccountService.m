//
//  NKAccountService.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKAccountService.h"

@implementation NKAccountService

-(void)dealloc{
    [super dealloc];
}

$singleService(NKAccountService, @"account");


#pragma mark Login
static NSString *const NKAPILogin = @"/login";
-(NKRequest*)loginWithUsername:(NSString*)username password:(NSString*)password andRequestDelegate:(NKRequestDelegate*)rd{

    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPILogin];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    
    [newRequest addPostValue:username forKey:@"account"];
    [newRequest addPostValue:password forKey:@"password"];
    
    [self addRequest:newRequest];
    
    
    return newRequest;
    
}


static NSString *const NKAPILogout = @"/logout";
-(NKRequest*)logoutWithRequestDelegate:(NKRequestDelegate*)rd{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPILogout];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMActionResult class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    [self addRequest:newRequest];
    
    
    return newRequest;
    
    
}

static NSString *const NKAPIRegister = @"/register";
-(NKRequest*)registerWithUsername:(NSString*)username password:(NSString*)password name:(NSString*)name avatar:(NSString*)avatar andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIRegister];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    [newRequest addPostValue:username forKey:@"account"];
    [newRequest addPostValue:password forKey:@"password"];
    [newRequest addPostValue:name forKey:@"name"];
    
    if (avatar) {
        [newRequest addPostValue:avatar forKey:@"avatar"];
    }
    
    [self addRequest:newRequest];
    return newRequest;
    
    
}

@end
