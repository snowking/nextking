//
//  NKUserService.h
//  WEIMI
//
//  Created by King on 11/14/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKServiceBase.h"

@interface NKUserService : NKServiceBase


dshared(NKUserService);

-(NKRequest*)getUserWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd;
-(NKRequest*)listUserWithUIDs:(NSArray*)uids andRequestDelegate:(NKRequestDelegate*)rd;


-(NKRequest*)followUserWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd;
-(NKRequest*)unFollowUserWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd;


-(NKRequest*)listFriendsWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd;
-(NKRequest*)inviteUserWithEmail:(NSString*)email andRequestDelegate:(NKRequestDelegate*)rd;

-(NKRequest*)setAvatarWithAvatar:(NSData*)avatar avatarPath:(NSString*)avatarPath andRequestDelegate:(NKRequestDelegate*)rd;


@end
