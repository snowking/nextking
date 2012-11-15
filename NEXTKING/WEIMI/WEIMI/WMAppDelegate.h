//
//  WMAppDelegate.h
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAppKey             @"2435344927"
#define kAppSecret          @"6bb8a017e2d5b0686eceb7d25b8ee525"
#define kAppRedirectURI     @"http://zuo.com"


@class SinaWeibo;

@interface WMAppDelegate : UIResponder <UIApplicationDelegate>{
    
    SinaWeibo *sinaweibo;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic) SinaWeibo *sinaweibo;

@end
