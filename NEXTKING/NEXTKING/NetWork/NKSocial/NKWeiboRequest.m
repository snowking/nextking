//
//  NKWeiboRequest.m
//  ZUO
//
//  Created by King on 1/6/13.
//  Copyright (c) 2013 King. All rights reserved.
//

#import "NKWeiboRequest.h"

@implementation NKWeiboRequest

@synthesize requestDelegate;

-(void)dealloc{
    
    [requestDelegate release];
    [super dealloc];
}


+ (id)requestWithURL:(NSString *)url
          httpMethod:(NSString *)httpMethod
              params:(NSDictionary *)params
     requestDelegate:(NKRequestDelegate*)rd{
    
    
    NKWeiboRequest *request = [super requestWithURL:url httpMethod:httpMethod params:params delegate:nil];
    request.delegate = request;
    request.requestDelegate = rd;
    return request;
    
}

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
        
    NKRequest *nkReqeust = [[[NKRequest alloc] init] autorelease];
    nkReqeust.error = error;
    [requestDelegate delegateFailedWithRequest:nkReqeust];

}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    NKRequest *nkReqeust = [[[NKRequest alloc] init] autorelease];
    nkReqeust.results = [NSArray arrayWithObject:result];
    [requestDelegate delegateFinishWithRequest:nkReqeust];
}

@end
