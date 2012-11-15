//
//  WMLoginViewController.m
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "WMLoginViewController.h"
#import "NKNavigator.h"
#import "NKAccountManager.h"
#import "WMAppDelegate.h"

#import "WMWeiboRegisterViewController.h"

@interface WMLoginViewController ()

@end

@implementation WMLoginViewController

@synthesize account;
@synthesize password;
@synthesize loginButton;

@synthesize user;


-(void)dealloc{
    
    [user release];
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NKAccountManager *manager = [NKAccountManager sharedAccountsManager];
    account.text = [manager.currentAccount account];
    password.text = [manager.currentAccount password];
    
    loginButton.enabled = [password.text length]>0&&[account.text length]>0;
    
    
    // Add this if you want to show the keyboard
    if ([account.text length]>0) {
        [password becomeFirstResponder];
    }
    else {
        [account becomeFirstResponder];
    }
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    sinaweibo.delegate = self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.titleLabel.text = @"登录";
    
    [self addBackButton];
    self.loginButton = [self addRightButtonWithTitle:@"完成"];
    
    
    account.delegate = self;
    password.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    sinaweibo.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tap:(UITapGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [account resignFirstResponder];
        [password resignFirstResponder];
    }
    
}

-(IBAction)loginWithWeibo:(id)sender{
    
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo logIn];
}

#pragma mark Login


-(void)loginOK:(NKRequest*)request{
    loginButton.enabled = YES;
    NSLog(@"%@", request.results);
    
    [[NKNavigator sharedNavigator] showLoginOKView];
    
}

-(void)loginFailed:(NKRequest*)request{
    
    loginButton.enabled = YES;
    
    NSLog(@"%@", request.errorCode);
    
}
-(IBAction)rightButtonClick:(id)sender{
    // Login
    
    if ([account.text length]<=0 || [password.text length]<=0) {
        
        return;
    }
    
    loginButton.enabled = NO;
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(loginOK:) andFailedSelector:@selector(loginFailed:)];
    
    NKMAccount *newAccount = [NKMAccount accountWithAccount:account.text password:password.text andShouldAutoLogin:[NSNumber numberWithBool:YES]];
    
    [[NKAccountManager sharedAccountsManager] loginWithAccount:newAccount andRequestDelegate:rd];
    
}


-(IBAction)forgetPassowrd:(id)sender{
    
    
}


#pragma mark UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    loginButton.enabled = [text length]>0 && (textField==account?[password.text length]>0:[account.text length]>0);
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == account) {
        [password becomeFirstResponder];
    }
    else if (textField == password) {
        [self rightButtonClick:nil];
    }
    
    return YES;
}



#pragma mark Aouth 

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
    WMAppDelegate *delegate = (WMAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
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
    
    WMWeiboRegisterViewController *weibo = [[WMWeiboRegisterViewController alloc] init];
    [self.navigationController pushViewController:weibo animated:YES];
    [weibo release];
    
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
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
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
    
    self.user = result;
    [self resetButtons];
}


@end
