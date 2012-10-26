//
//  NSURL+StringURLEncode.m
//  LWSDK
//
//  Created by King Connect on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSURL+StringURLEncode.h"

@implementation NSURL (StringURLEncode)

+(id)URLWithUnEncodeString:(NSString *)URLString{
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [self URLWithString:URLString];
}

@end
