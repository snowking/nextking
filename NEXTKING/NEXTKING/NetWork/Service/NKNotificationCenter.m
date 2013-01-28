//
//  NKNotificationCenter.m
//  ZUO
//
//  Created by King on 12/20/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKNotificationCenter.h"
#import "NKConfig.h"

NSString *const NKRemoteNotificationKey = @"NKRemoteNotificationKey";

@implementation NKNotificationCenter



-(void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NKLoginFinishNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NKWillLogoutNotificationKey object:nil];
    
    [super dealloc];
}

$singleService(NKNotificationCenter, @"notification");



-(id)init{
    
    self = [super init];
    if (self) {
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFinish) name:NKLoginFinishNotificationKey object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutFinish) name:NKWillLogoutNotificationKey object:nil];
        
        
        
    }
    return self;
}

-(void)getNotificationsCount{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getNotificationsCount) object:nil];
    //[[LWRemindService sharedLWRemindService] getUnreadRemindWithTicketDelegate:[LWTicketDelegate ticketDelegateWithTarget:self finishSelector:@selector(getNotificationsCountOK:) andFailedSelector:nil]];
    [self performSelector:@selector(getNotificationsCount) withObject:nil afterDelay:30.0];
    
}


-(void)loginFinish{
    
    [self getNotificationsCount];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
}

-(void)logoutFinish{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getNotificationsCount) object:nil];
//    self.totalNotificationCount = [NSNumber numberWithInt:-1];
//    self.notificationCount.reminds = nil;
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
}

-(void)appBecomeActive{
    
    //if ([ me]) {
        
        [self getNotificationsCount];
        
    //}
    
}
-(void)appResignActive{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getNotificationsCount) object:nil];
    
}



#pragma mark APN
- (void)postDeviceToken:(NSData*)deviceToken
{
	NSString *deviceTokenStr = [NSString stringWithFormat:@"%@", deviceToken];
	deviceTokenStr = [deviceTokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];
	deviceTokenStr = [deviceTokenStr substringWithRange:NSMakeRange(1, [deviceTokenStr length]-2)];
    
    //NSLog(@"%@", deviceTokenStr);
    
    //[[LWInternalService sharedLWInternalService] bindAPNWithKey:deviceTokenStr andTicketDelegate:nil];
    id target = [[NKConfig sharedConfig] apnTarget];
    SEL method = [[NKConfig sharedConfig] apnMethod];
    
    if ([target respondsToSelector:method]) {
        [target performSelector:method withObject:deviceTokenStr withObject:nil];
    }
    
}







@end
