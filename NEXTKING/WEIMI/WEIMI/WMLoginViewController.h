//
//  WMLoginViewController.h
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKViewController.h"
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"

@interface WMLoginViewController : NKViewController <UITextFieldDelegate, SinaWeiboDelegate, SinaWeiboRequestDelegate>{
    
    IBOutlet UITextField *account;
    IBOutlet UITextField *password;
    
    IBOutlet UIButton *loginButton;
    
    NSDictionary *user;
}

@property (nonatomic, assign) UITextField *account;
@property (nonatomic, assign) UITextField *password;
@property (nonatomic, assign) UIButton    *loginButton;

@property (nonatomic, retain) NSDictionary *user;


-(IBAction)forgetPassowrd:(id)sender;

-(IBAction)loginWithWeibo:(id)sender;
-(void)getUserInfo;
- (SinaWeibo *)sinaweibo;

@end
