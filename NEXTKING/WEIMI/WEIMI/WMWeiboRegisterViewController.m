//
//  WMWeiboRegisterViewController.m
//  WEIMI
//
//  Created by King on 11/15/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMWeiboRegisterViewController.h"
#import "NKAccountManager.h"

@interface WMWeiboRegisterViewController ()

@end

@implementation WMWeiboRegisterViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [account becomeFirstResponder];
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    sinaweibo.delegate = self;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = @"微博登录成功";
    
    
    [self getUserInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)rightButtonClick:(id)sender{
    // Login
    
    if ([account.text length]<=0 || [password.text length]<=0) {
        
        return;
    }
    
    loginButton.enabled = NO;
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(registerOK:) andFailedSelector:@selector(registerFailed:)];
    
    [[NKAccountService sharedNKAccountService] registerWithUsername:account.text password:password.text name:[user objectOrNilForKey:@"screen_name"] avatar:[user objectOrNilForKey:@"avatar_large"] andRequestDelegate:rd];
}

-(void)registerOK:(NKRequest*)request{
    
    [self loginWithMy];
    
}

-(void)registerFailed:(NKRequest*)request{
    
    
}

-(void)loginWithMy{
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(loginOK:) andFailedSelector:@selector(loginFailed:)];
    
    NKMAccount *newAccount = [NKMAccount accountWithAccount:account.text password:password.text andShouldAutoLogin:[NSNumber numberWithBool:YES]];
    
    [[NKAccountManager sharedAccountsManager] loginWithAccount:newAccount andRequestDelegate:rd];

}

@end
