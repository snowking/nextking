//
//  NKSystemInfo.h
//  ZUO
//
//  Created by King on 12/20/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *const NKCurrentAppVersion;


@interface NKSystemInfo : NSObject


+(NSString*)deviceString;
+(NSString*)versionString;
+(NSString*)currentVersionString;

+(void)updateVersion;


@end
