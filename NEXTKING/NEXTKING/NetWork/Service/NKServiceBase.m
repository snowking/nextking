//
//  NKServiceBase.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKServiceBase.h"
#import "NKSDK.h"
#import <commoncrypto/CommonDigest.h>

//NSString * const kAPIBaseUrl = @"http://api.NK.tj/v1";
NSString * const kAPIBaseUrl = @"http://127.0.0.1:8888/nextking_server/index.php";

@implementation NKServiceBase


@synthesize serviceName;

-(void)dealloc{
    
    [serviceName release];
    [super dealloc];
    
}



-(NSString*)makeMD5:(NSString*)str{
    
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}


-(void)addRequest:(NKRequest*)request{
    [[NKSDK sharedSDK] addRequest:request];
    
    NSLog(@"%@, %@", request.url, request.postBody);
    // Start
    [request.requestDelegate delegateStartWithRequest:request];
}


-(NSString *)serviceBaseURL{
    if (self.serviceName) {
        return [kAPIBaseUrl stringByAppendingFormat:@"/%@",self.serviceName];
    }
    return kAPIBaseUrl;
    
}
@end
