//
//  NKAccountManager.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKAccountManager.h"
#import "NKDataStore.h"

@implementation NKAccountManager

@synthesize currentAccount;
@synthesize allAccounts;

-(void)dealloc{
    
    [currentAccount release];
    [allAccounts release];
    
    [super dealloc];
}

static NKAccountManager *_sharedAccountsManager = nil;

+(id)sharedAccountsManager{
    
    if (!_sharedAccountsManager) {
        _sharedAccountsManager = [[self alloc] init];
    }
    
    return _sharedAccountsManager;
}

-(id)init{
    self = [super init];
    if (self) {
        
        self.allAccounts = [NSMutableArray arrayWithContentsOfFile:[[NKDataStore sharedDataStore] accountsPath]];
        if ([allAccounts count]>0) {
            NSDictionary *firstDic = [allAccounts objectAtIndex:0];
            self.currentAccount = [NKMAccount accountFromLocalDic:firstDic];
            
        }
        else{
            self.allAccounts = [NSMutableArray array];
        }
    }
    return self;
}


-(void)saveAccountsFile{
    
    if (!self.currentAccount) {
        return;
    }
    
    NSDictionary *dic = [self.currentAccount persistentDic];
    
    NKMAccount *tempA = nil;
    for (NSDictionary *alreadyhave in allAccounts) {
        
        tempA = [NKMAccount accountFromLocalDic:alreadyhave];
        if ([tempA.mid isEqualToString:self.currentAccount.mid]) {
            [allAccounts removeObject:alreadyhave];
            break;
        }
    }
    [self.allAccounts insertObject:dic atIndex:0];
    [self.allAccounts writeToFile:[[NKDataStore sharedDataStore] accountsPath] atomically:YES];
}



#pragma mark Login and Logout
-(BOOL)canAutoLogin{
    //return YES;
    return [self.currentAccount.shouldAutoLogin boolValue]&&self.currentAccount.password;
}
-(void)logOut{
    // Will set the current account to nil if we do not want to show the email and password again
    
    [[NKAccountService sharedNKAccountService] logoutWithRequestDelegate:nil];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NKWillLogoutNotificationKey object:nil];
    
    self.currentAccount.shouldAutoLogin = [NSNumber numberWithBool:NO];
    self.currentAccount.password = @"";
    [self saveAccountsFile];
    
}

-(BOOL)autoLogin{
    
    // Should AutoLogin?
    if ([self canAutoLogin]) {
        [self loginWithAccount:self.currentAccount];
        return YES;
    }
    
    return NO;
}

-(void)loginFinish:(NKRequest*)request{
    
    NKMUser *me = [NKMUser meFromUser:[request.results lastObject]];
    
    self.currentAccount.mid = me.mid;
    [self saveAccountsFile];
    [[NKDataStore sharedDataStore] cacheObject:me forCacheKey:NKCachePathProfile];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NKLoginFinishNotificationKey object:nil];
    
}

-(void)loginWithAccount:(id)account andRequestDelegate:(NKRequestDelegate*)rd{
    
    self.currentAccount = account;
    
    rd.inspector = self;
    rd.finishInspectorSelector = @selector(loginFinish:);
    
    [NKMUser meFromUser:[[NKDataStore sharedDataStore] cachedObjectOf:NKCachePathProfile andClass:[NKMUser class]]];
    
    [[NKAccountService sharedNKAccountService] loginWithUsername:self.currentAccount.account password:self.currentAccount.password andRequestDelegate:rd];
    
}

-(void)loginWithAccount:(NKMAccount*)account{
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:nil finishSelector:nil andFailedSelector:nil];
    
    [self loginWithAccount:account andRequestDelegate:rd];
    
}


@end
