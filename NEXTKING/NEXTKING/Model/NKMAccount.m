//
//  NKMAccount.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKMAccount.h"

NSString *const NKWillLogoutNotificationKey = @"NKWillLogoutNotificationKey";
NSString *const NKLoginFinishNotificationKey = @"NKLoginFinishNotificationKey";

@implementation NKMAccount

@synthesize account;
@synthesize password;
@synthesize shouldSavePassword;
@synthesize shouldAutoLogin;


-(void)dealloc{
    
    [account release];
    [password release];
    
    [shouldSavePassword release];
    [shouldAutoLogin release];
    
    [super dealloc];
}

static NKMAccount *_reg = nil;

+(id)registerAccount{
    
    if (!_reg) {
        _reg = [[NKMAccount alloc] init];
    }
    
    return _reg;
}

+(id)cleanRegisterAccout{
    
    [_reg release];
    _reg = nil;
    return nil;
}

-(NSString*)description{
    
    return [NSString stringWithFormat:@"<%@> account:%@,  ", NSStringFromClass([self class]), account];
}

+(id)accountWithAccount:(NSString *)aloginName password:(NSString *)apassword andShouldAutoLogin:(NSNumber *)autoLogin{
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:aloginName, @"account", apassword, @"password", autoLogin, @"shouldAutoLogin", nil];
    
    return [NKMAccount accountFromLocalDic:dic];
    
    
}

+(id)accountFromLocalDic:(NSDictionary*)dic{
    
    NKMAccount *newAccount = [[self alloc] init];
    if (newAccount) {
        
        newAccount.jsonDic = dic;
        newAccount.mid = [dic objectForKey:@"id"];
        newAccount.account = [dic objectForKey:@"account"];
        newAccount.password = [dic objectForKey:@"password"];
        newAccount.shouldAutoLogin = [dic objectForKey:@"shouldAutoLogin"];
    }
    
    return  [newAccount autorelease];
    
}
-(NSDictionary*)persistentDic{
    
    return [NSDictionary dictionaryWithObjectsAndKeys:self.mid, @"id", self.account, @"account", self.password, @"password", self.shouldAutoLogin, @"shouldAutoLogin", nil];
}


@end