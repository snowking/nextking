//
//  NKMUser.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKModel.h"

typedef enum{
	NKMUserCreateTypeFromWeb   =  5,
	NKMUserCreateTypeFromContact  =  0
}NKMUserCreateType;


extern NSString *const NKRelationFriend;
extern NSString *const NKRelationFollow;
extern NSString *const NKRelationFollower;

extern NSString *const NKGenderKeyMale;
extern NSString *const NKGenderKeyFemale;
extern NSString *const NKGenderKeyUnknown;

@interface NKMUser : NKModel{
    
    
    // Create Type
	NKMUserCreateType createType;
    
    // Name and pinyin
    NSString *showName;
    NSString *name;
    NSString *searchKey;
    
    //Contact
    NSString *mobile;
    NSString *email;
    
    // Gender, company, brief and so on
    NSString *gender; // Only support for male female unknown
    NSString *company;
    NSString *location; //no gps info in this version, just the place.
    NSString *birthday;
    NSString *sign;
    NSString *city;

    
    NSString *avatarPath;
    
#if TARGET_OS_IPHONE
    UIImage  *avatar;
#else //if TARGET_OS_MAC
    NSImage  *avatar;
#endif
    
    
    NSString *relation;
    
    
    
}

@property (nonatomic, assign) NKMUserCreateType createType;


@property (nonatomic, retain) NSString *showName;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *searchKey;

@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *email;

@property (nonatomic, retain) NSString *gender;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *birthday;
@property (nonatomic, retain) NSString *sign;
@property (nonatomic, retain) NSString *city;


@property (nonatomic, retain) NSString *avatarPath;

#if TARGET_OS_IPHONE
@property (nonatomic, retain) UIImage  *avatar;
#else
@property (nonatomic, retain) NSImage  *avatar;
#endif

@property (nonatomic, retain) NSString *relation;

+(id)userFromDic:(NSDictionary*)dic;

+(id)user;
#if TARGET_OS_IPHONE
+(id)userWithName:(NSString*)tname phoneNumber:(NSString*)tphoneNumber andAvatar:(UIImage*)tavatar;
#endif

+(id)meFromUser:(NKMUser*)user;
+(id)me;

-(NSString*)profileUpdateString;

+(NSPredicate*)predicateWithSearchString:(NSString*)searchString;



#pragma mark DownloadAndUpload
@property (nonatomic, assign) ASIHTTPRequest *avatarRequest;
@property (nonatomic, assign) BOOL downloadingAvatar;

-(void)downLoadAvatar;




@end
