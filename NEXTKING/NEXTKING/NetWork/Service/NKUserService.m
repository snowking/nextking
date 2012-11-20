//
//  NKUserService.m
//  WEIMI
//
//  Created by King on 11/14/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKUserService.h"

@implementation NKUserService


-(void)dealloc{
    [super dealloc];
}

$singleService(NKUserService, @"user");


static NSString *const NKAPIGetUser = @"/get";
-(NKRequest*)getUserWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIGetUser];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    if (uid) {
        [newRequest addPostValue:uid forKey:@"id"];
    }

    [self addRequest:newRequest];
    return newRequest;
    
}

static NSString *const NKAPIListUser = @"/li";
-(NKRequest*)listUserWithUIDs:(NSArray*)uids andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIListUser];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeArray andResultKey:@""];
    
    for (NSString *uid in uids) {
         [newRequest addPostValue:uid forKey:@"id"];
    }

    [self addRequest:newRequest];
    return newRequest;
    
}

static NSString *const NKAPIFollowUser = @"/follow";
-(NKRequest*)followUserWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIFollowUser];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    if (uid) {
        [newRequest addPostValue:uid forKey:@"id"];
    }
    
    [self addRequest:newRequest];
    return newRequest;
    
}


static NSString *const NKAPIUNFollowUser = @"/unfollow";
-(NKRequest*)unFollowUserWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIUNFollowUser];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    if (uid) {
        [newRequest addPostValue:uid forKey:@"id"];
    }
    
    [self addRequest:newRequest];
    return newRequest;
    
}

static NSString *const NKAPIInvite = @"/invite";
-(NKRequest*)inviteUserWithEmail:(NSString*)email andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIInvite];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    if (email) {
        [newRequest addPostValue:email forKey:@"email"];
    }
    
    [self addRequest:newRequest];
    return newRequest;
    
    
}

static NSString *const NKAPIListFriends = @"/friend_list";
-(NKRequest*)listFriendsWithUID:(NSString*)uid andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIListFriends];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeArray andResultKey:@""];
    
    if (uid) {
        [newRequest addPostValue:uid forKey:@"id"];
    }
    
    [self addRequest:newRequest];
    return newRequest;
    
    
}

static NSString *const NKAPISetAvatar = @"/avatar";
-(NKRequest*)setAvatarWithAvatar:(NSData*)avatar avatarPath:(NSString*)avatarPath andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIListFriends];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMUser class] resultType:NKResultTypeSingleObject andResultKey:@""];
    
    if (avatar) {
        [newRequest addData:avatar withFileName:@"avatar.jpg" andContentType:@"image/jpeg" forKey:@"avatar"];
    }
    
    if (avatarPath) {
        [newRequest addPostValue:avatarPath forKey:@"avatarPath"];
    }
    
    [self addRequest:newRequest];
    return newRequest;
}

@end
