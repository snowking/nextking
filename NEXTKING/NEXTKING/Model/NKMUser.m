//
//  NKMUser.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKMUser.h"


NSString *const NKRelationFriend = @"friend";
NSString *const NKRelationFollow = @"follow";
NSString *const NKRelationFollower = @"follower";

NSString *const NKGenderKeyMale = @"male";
NSString *const NKGenderKeyFemale = @"female";
NSString *const NKGenderKeyUnknown = @"unknown";

@implementation NKMUser

@synthesize createType;

@synthesize showName;
@synthesize name;
@synthesize searchKey;

@synthesize mobile;
@synthesize email;

@synthesize gender;
@synthesize company;
@synthesize location;
@synthesize birthday;
@synthesize sign;
@synthesize city;


@synthesize avatarPath;
@synthesize avatar;

@synthesize relation;


-(void)dealloc{
    
    [self.avatarRequest clearDelegatesAndCancel];
    
    
    [showName release];
    [name release];
    [searchKey release];
    
    [mobile release];
    [email release];
    
    [gender release];
    [company release];
    [location release];
    [birthday release];
    [sign release];
    [city release];

    [avatarPath release];
    [avatar release];
    
    [relation release];
    
    [super dealloc];
}



static NKMUser *_me = nil;
+(id)meFromUser:(NKMUser*)User{
    _me = User;
    return _me;
    
}
+(id)me{
    
    return _me;
}

+(id)user{
    NKMUser *newUser = [[self alloc] init];
    newUser.createType = NKMUserCreateTypeFromContact;
    return [newUser autorelease];
}
#if TARGET_OS_IPHONE
+(id)userWithName:(NSString*)tname phoneNumber:(NSString*)tphoneNumber andAvatar:(UIImage*)tavatar{
	
	NKMUser *newUser = [[self alloc] init];
	newUser.createType = NKMUserCreateTypeFromContact;
	newUser.name = tname;
    newUser.mobile = tphoneNumber;
	newUser.avatar = tavatar;
    //    newUser.invited = NO;
	return [newUser autorelease];
}
#endif

+(id)modelFromDic:(NSDictionary*)dic{
    
    return [self userFromDic:dic];
}

/*
 -(void)logCount{
 
 NSLog(@"%d", [name retainCount]);
 [self performSelector:@selector(logCount) withObject:nil afterDelay:1.0];
 
 }
 */

-(NSString*)description{
    
    return [NSString stringWithFormat:@" <%@> name:%@, id:%@, city:%@, avatar:%@, sign:%@", NSStringFromClass([self class]), name, mid, city, avatarPath, sign];
}

-(NSDictionary*)cacheDic{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // ID  !!!
    NKBindValueToKeyForParameterToDic(@"id",self.mid,dic);
    
    // Name
    NKBindValueToKeyForParameterToDic(@"name",self.name,dic);
    NKBindValueToKeyForParameterToDic(@"pinyin",self.searchKey,dic);
    
    // Contact
    //NKBindValueToKeyForParameterToDic(@"mobile", self.mobilePhone, dic);
    
    // Avatar
    NKBindValueToKeyForParameterToDic(@"avatar", self.avatarPath, dic);
    //NKBindValueToKeyForParameterToDic(@"avatarBig", self.bigAvatarPath, dic);
    
    // Gender
    //    NKBindValueToKeyForParameterToDic(@"gender", self.gender, dic);
    //    NKBindValueToKeyForParameterToDic(@"company", self.company, dic);
    //    NKBindValueToKeyForParameterToDic(@"brief", self.brief, dic);
    //    NKBindValueToKeyForParameterToDic(@"city", self.city, dic);
    //    NKBindValueToKeyForParameterToDic(@"birthday", self.birthday, dic);
    
    return dic;
}

//-(oneway void)release{
//
//    [super release];
//
//    NSLog(@"%d", [self retainCount]);
//}

-(void)bindValuesForDic:(NSDictionary*)dic{
    
    // Name
    NKBindValueWithKeyForParameterFromDic(@"name", self.name, dic);
    NKBindValueWithKeyForParameterFromDic(@"search_key", self.searchKey, dic);
    
    // Contact
    NKBindValueWithKeyForParameterFromDic(@"mobile", self.mobile, dic);
    NKBindValueWithKeyForParameterFromDic(@"email", self.email, dic);
    
    /*
     // Avatar
     if (avatar && self.avatarPath && [dic objectOrNilForKey:@"avatar"] && ![self.avatarPath isEqualToString:[dic objectOrNilForKey:@"avatar"]]) {
     NKBindValueWithKeyForParameterFromDic(@"avatar", self.avatarPath, dic);
     [self downLoadAvatar];
     
     }
     else {
     NKBindValueWithKeyForParameterFromDic(@"avatar", self.avatarPath, dic);
     }
     
     if (bigAvatar && self.bigAvatarPath && [dic objectOrNilForKey:@"avatarBig"] && ![self.bigAvatarPath isEqualToString:[dic objectOrNilForKey:@"avatarBig"]]) {
     NKBindValueWithKeyForParameterFromDic(@"avatarBig", self.bigAvatarPath, dic);
     [self downloadBigAvatar];
     
     }
     else {
     NKBindValueWithKeyForParameterFromDic(@"avatarBig", self.bigAvatarPath, dic);
     }
     */
    
    NKBindValueWithKeyForParameterFromDic(@"avatar", self.avatarPath, dic);
    //    NKBindValueWithKeyForParameterFromDic(@"avatarBig", self.bigAvatarPath, dic);
    
    // Gender
    NKBindValueWithKeyForParameterFromDic(@"gender", self.gender, dic);
    NKBindValueWithKeyForParameterFromDic(@"company", self.company, dic);
    NKBindValueWithKeyForParameterFromDic(@"location", self.location, dic);
    NKBindValueWithKeyForParameterFromDic(@"sign", self.sign, dic);
    NKBindValueWithKeyForParameterFromDic(@"birthday", self.birthday, dic);
    NKBindValueWithKeyForParameterFromDic(@"city", self.city, dic);
    
    
    NKBindValueWithKeyForParameterFromDic(@"relation", self.relation, dic);
    
    /*
     // Friend info
     NKBindValueWithKeyForParameterFromDic(@"commonFriendCount", self.commonFriendCount, dic);
     NKBindValueWithKeyForParameterFromDic(@"followerCount", self.followerCount, dic);
     NKBindValueWithKeyForParameterFromDic(@"friendCount", self.friendCount, dic);
     NKBindValueWithKeyForParameterFromDic(@"friend", self.isFriend, dic);
     NKBindValueWithKeyForParameterFromDic(@"isBlocked", self.isBlocked, dic);
     NKBindValueWithKeyForParameterFromDic(@"connectionType", self.relationType, dic);
     */
    
    
    /*
     NSArray *circlesArray = [dic objectOrNilForKey:@"circles"];
     if ([circlesArray count]) {
     self.circles = [NSMutableArray arrayWithCapacity:[circlesArray count]];
     
     for (NSDictionary *circleDic in circlesArray) {
     [self.circles addObject:[NKMDCircle modelFromDic:circleDic]];
     }
     
     }
     else if (circlesArray) {
     self.circles = [NSMutableArray array];
     }
     
     // Login State and time
     if ([dic objectOrNilForKey:@"lastLoginTime"]!=nil) {
     self.lastLoginTime = [NSDate dateWithTimeIntervalSince1970:[[dic objectOrNilForKey:@"lastLoginTime"] longLongValue]/1000];
     }
     if ([dic objectOrNilForKey:@"createdAt"]) {
     self.createAt = [NSDate dateWithTimeIntervalSince1970:[[dic objectOrNilForKey:@"createdAt"] longLongValue]/1000];
     }
     
     // PostInfo
     NKBindValueWithKeyForParameterFromDic(@"postCount", self.postCount, dic);
     NKBindValueWithKeyForParameterFromDic(@"eventCount", self.eventCount, dic);
     
     // Recommend
     NKBindValueWithKeyForParameterFromDic(@"recommendReason", self.recommendReason, dic);
     NKBindValueWithKeyForParameterFromDic(@"recommendType", self.recommendType, dic);
     
     */
    
}

+(id)modelFromCache:(NSDictionary*)dic{
    return [self userFromDic:dic isCache:YES];
}

-(void)bindValuesFromCache:(NSDictionary*)dic{
    
    // Name
    NKBindValueWithKeyForParameterFromCache(@"name",self.name,dic);
    NKBindValueWithKeyForParameterFromCache(@"search_key",self.searchKey,dic);
    
    // Contact
    //NKBindValueWithKeyForParameterFromCache(@"mobile", self.mobilePhone, dic);
    
    // Avatar
    NKBindValueWithKeyForParameterFromCache(@"avatar", self.avatarPath, dic);
    //    NKBindValueWithKeyForParameterFromCache(@"avatarBig", self.bigAvatarPath, dic);
    
}

+(id)userFromDic:(NSDictionary*)dic isCache:(BOOL)cache{
    if (!dic) {
        return nil;
    }
    
    NSString *theUID = [NSString stringWithFormat:@"%@", [dic objectOrNilForKey:@"id"]];
    NKMUser *cachedUser = [[[NKMemoryCache sharedMemoryCache] cachedUsers] objectOrNilForKey:theUID];
    if (cachedUser) {
        
        cache?[cachedUser bindValuesFromCache:dic]:[cachedUser bindValuesForDic:dic];
        
        return cachedUser;
    }
    else{
        NKMUser *newUser = [[NKMUser alloc] init];
		newUser.createType = NKMUserCreateTypeFromWeb;
        newUser.jsonDic = dic;
        // ID
        newUser.mid  = theUID;
        [newUser bindValuesForDic:dic];
        [[[NKMemoryCache sharedMemoryCache] cachedUsers] setObject:newUser forKey:theUID];
        return [newUser autorelease];
    }
    
}

+(id)userFromDic:(NSDictionary*)dic{
    
    return [self userFromDic:dic isCache:NO];
}


-(NSString*)profileUpdateString{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObjectOrNil:self.name forKey:@"name"];
    [dic setObjectOrNil:self.sign forKey:@"sign"];
    [dic setObjectOrNil:self.gender forKey:@"gender"];
    
    
    /*
     NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
     self.name, @"name",
     self.brief, @"brief",
     self.city, @"city",
     self.company, @"company",
     self.gender, @"gender",
     self.birthday, @"birthday",
     nil];
     */
    
    return [dic JSONString];
}


+(NSPredicate*)predicateWithSearchString:(NSString*)searchString{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(mobile BEGINSWITH[cd] %@) OR (showName contains [cd] %@) OR (name contains [cd] %@) OR (searchKey contains [cd] %@)",searchString,searchString,searchString, searchString];
    
    return predicate;
    
}



#if TARGET_OS_IPHONE
-(UIImage*)avatar{
    if (!avatar && self.createType==NKMUserCreateTypeFromWeb /* the User from web, will have the uid, and we can get avatar from web, the User we create by ourself has no uid*/) {
        if (!self.downloadingAvatar) {
            [self downLoadAvatar];
        }
        return [UIImage imageNamed:@"default_portrait.png"];
        
    }
    
    if (!avatar && self.createType==NKMUserCreateTypeFromContact) {
        self.avatar = [UIImage imageNamed:@"default_portrait.png"];
    }
    return avatar;
}
-(void)downLoadAvatarFinish:(ASIHTTPRequest*)request{
    
    UIImage *avatarImage = [UIImage imageWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
    if (avatarImage) {
        self.avatar = avatarImage;
        self.downloadingAvatar = NO;
    }
    
    self.avatarRequest = nil;
    
}


#else
-(NSImage*)avatar{
    if (!avatar && self.createType==NKMUserCreateTypeFromWeb /* the User from web, will have the uid, and we can get avatar from web, the User we create by ourself has no uid*/) {
        if (!self.downloadingAvatar) {
            [self downLoadAvatar];
        }
        return [NSImage imageNamed:@"default_portrait.png"];
        
    }
    
    if (!avatar && self.createType==NKMUserCreateTypeFromContact) {
        self.avatar = [NSImage imageNamed:@"default_portrait.png"];
    }
    return avatar;
}
-(void)downLoadAvatarFinish:(ASIHTTPRequest*)request{
    
    NSImage *avatarImage = [[[NSImage alloc] initWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]] autorelease];
    if (avatarImage) {
        self.avatar = avatarImage;
        self.downloadingAvatar = NO;
    }
    self.avatarRequest = nil;
}
#endif


#pragma mark DownloadAndUpload
@synthesize downloadingAvatar;
@synthesize avatarRequest;

-(void)downLoadAvatarFailed:(ASIHTTPRequest*)request{
    self.downloadingAvatar = NO;
    self.avatarRequest = nil;
}

-(void)downLoadAvatar{
    
    if (self.downloadingAvatar) {
        return;
    }
    self.downloadingAvatar = YES;
    
    NSString *finalString = self.avatarPath;
    
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithImageURL:[NSURL URNKithUnEncodeString:self.avatarPath]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithImageURL:[NSURL URLWithString:finalString]];
    request.delegate = self;
    self.avatarRequest = request;
    [request setDidFinishSelector:@selector(downLoadAvatarFinish:)];
    [request setDidFailSelector:@selector(downLoadAvatarFailed:)];
    
    //[[NKSDK sharedSDK] addTicket:(NKTicket*)request];
    [request startAsynchronous];
    
}

@end

