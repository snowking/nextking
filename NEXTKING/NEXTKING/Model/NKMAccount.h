//
//  NKMAccount.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKMUser.h"

extern NSString *const NKWillLogoutNotificationKey;
extern NSString *const NKLoginFinishNotificationKey;

@interface NKMAccount : NKMUser{
    
    // password, should We store the password here
    NSString *account; // Do not use it here now
    NSString *password;
    
    NSNumber *shouldSavePassword;
    NSNumber *shouldAutoLogin;
}
@property (nonatomic, retain) NSString *account;
@property (nonatomic, retain) NSString *password;


@property (nonatomic, retain) NSNumber *shouldSavePassword;
@property (nonatomic, retain) NSNumber *shouldAutoLogin;

+(id)accountFromLocalDic:(NSDictionary*)dic;
+(id)accountWithAccount:(NSString*)aloginName password:(NSString*)apassword andShouldAutoLogin:(NSNumber*)autoLogin;

-(NSDictionary*)persistentDic;


+(id)registerAccount;

@end
