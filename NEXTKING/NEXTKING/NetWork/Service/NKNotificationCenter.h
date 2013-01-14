//
//  NKNotificationCenter.h
//  ZUO
//
//  Created by King on 12/20/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKServiceBase.h"


extern NSString *const NKRemoteNotificationKey;

@interface NKNotificationCenter : NKServiceBase

dshared(NKNotificationCenter);


-(void)getNotificationsCount;

- (void)postDeviceToken:(NSData*)deviceToken;


@end
