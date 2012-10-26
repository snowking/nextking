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

@interface WMLoginViewController ()

@end

@implementation WMLoginViewController

@synthesize account;
@synthesize password;
@synthesize loginButton;

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


@end
