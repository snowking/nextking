//
//  NKAccountService.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKServiceBase.h"

@interface NKAccountService : NKServiceBase

dshared(NKAccountService);


#pragma mark Login/Logout

-(NKRequest*)loginWithUsername:(NSString*)username password:(NSString*)password andRequestDelegate:(NKRequestDelegate*)rd;

-(NKRequest*)logoutWithRequestDelegate:(NKRequestDelegate*)rd;

-(NKRequest*)registerWithUsername:(NSString*)username password:(NSString*)password name:(NSString*)name avatar:(NSString*)avatar andRequestDelegate:(NKRequestDelegate*)rd;

@end
