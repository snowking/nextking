//
//  NKAccountManager.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKSDK.h"

@interface NKAccountManager : NSObject{
    
    NKMAccount *currentAccount;
    NSMutableArray *allAccounts;
}

@property (nonatomic, retain) NKMAccount *currentAccount;
@property (nonatomic, retain) NSMutableArray *allAccounts;


+(id)sharedAccountsManager;

// Login and Logout
-(BOOL)canAutoLogin;
-(void)loginWithAccount:(id)account andRequestDelegate:(NKRequestDelegate*)rd;
-(BOOL)autoLogin;
-(void)logOut;

-(void)saveAccountsFile;



@end
