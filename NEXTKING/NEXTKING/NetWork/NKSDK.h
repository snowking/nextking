//
//  NKSDK.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKRequest.h"
#import "ASINetworkQueue.h"
#import "NKAccountService.h"
#import "NKRecordService.h"
#import "NKUserService.h"
#import "NKNotificationCenter.h"

@interface NKSDK : NSObject{
    
@private
    ASINetworkQueue *requestQueue;
}


@property (nonatomic, retain) ASINetworkQueue *requestQueue;

+(NKSDK*)sharedSDK;


-(void)addRequest:(NKRequest*)request;

@end
