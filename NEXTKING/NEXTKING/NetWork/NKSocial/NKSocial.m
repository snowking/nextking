//
//  NKSocial.m
//  ZUO
//
//  Created by King on 12/29/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKSocial.h"


NSString *const NKSocialServiceTypeSinaWeibo = @"SinaWeibo";

@implementation NKSocial

@synthesize sinaWeibo;
@synthesize loginRD;

-(void)dealloc{
    
    [sinaWeibo release];
    
    [super dealloc];
}


static NKSocial *_sharedSocial = nil;

+(id)social{
    
    if (!_sharedSocial) {
        _sharedSocial = [[self alloc] init];
    }
    return _sharedSocial;
}


-(SinaWeibo*)initSinaWeiboWithAppKey:(NSString *)appKey appSecret:(NSString *)appSecrect
              appRedirectURI:(NSString *)appRedirectURI
                 andDelegate:(id<SinaWeiboDelegate>)delegate{
    
    self.sinaWeibo = [[[SinaWeibo alloc] initWithAppKey:appKey appSecret:appSecrect appRedirectURI:appRedirectURI andDelegate:delegate] autorelease];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaWeibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaWeibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaWeibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    sinaWeibo.delegate = self;
    
    return self.sinaWeibo;
    
}













#pragma mark Aouth

-(void)loginWithSinaWeiboWithRequestDelegate:(NKRequestDelegate*)rd{
    
    self.loginRD = rd;
    [self.sinaWeibo logIn];
    
}

-(void)resetButtons{
    
}

-(void)getUserInfo{
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json"
                       params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"]
                   httpMethod:@"GET"
                     delegate:self];
}

- (SinaWeibo *)sinaweibo
{
    return sinaWeibo;
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self resetButtons];
    [self storeAuthData];
    
//    WMWeiboRegisterViewController *weibo = [[WMWeiboRegisterViewController alloc] init];
//    [self.navigationController pushViewController:weibo animated:YES];
//    [weibo release];
    
    [loginRD delegateFinishWithRequest:nil];
    
    
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
    [self resetButtons];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
    [loginRD delegateFailedWithRequest:nil];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
    
    NKRequest *request = [[[NKRequest alloc] init] autorelease];
    request.error = error;
    [loginRD delegateFailedWithRequest:request];
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
    [self resetButtons];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    
    NSLog(@"%@", error);
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    
    NSLog(@"%@", result);
    
    [self resetButtons];
}




@end
