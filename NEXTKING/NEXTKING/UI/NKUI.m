//
//  NKUI.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKUI.h"
#import "NKNavigator.h"
#import "NKAccountManager.h"
#import "WMWelcomeViewController.h"
#import "WMHomeViewController.h"

@interface NKUI ()

@end

@implementation NKUI

@synthesize navigator;
@synthesize nkBackgroundView;
@synthesize currentController;

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NKWillLogoutNotificationKey object:nil];
    
    [currentController release];
    
    [super dealloc];
}

static NKUI * _NKUI = nil;

+(id)sharedNKUI{
    
    if (!_NKUI) {
        _NKUI = [[NKUI alloc] init];
    }
    
    return _NKUI;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:NKWillLogoutNotificationKey object:nil];
    }
    return self;
}

-(void)logout{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    
    [self showWelcome];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.nkBackgroundView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, NKMainHeight-NKNavigatorHeight)] autorelease];
    self.nkBackgroundView.userInteractionEnabled = YES;
    //zuoBackgroundView.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:nkBackgroundView];
    
    self.navigator = [NKNavigator sharedNavigator];
    [self.view addSubview:navigator];
    [self showDefaultViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark NaviTabAnimate

-(void)showNaviTab{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigator.frame = CGRectMake(0, NKMainHeight-NKNavigatorHeight, 320, NKNavigatorHeight);
    }];
}

-(void)hideNaviTab{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigator.frame = CGRectMake(0, NKMainHeight, 320, NKNavigatorHeight);
    }];
}


#pragma mark Show

-(void)showWelcome{
    [self showViewControllerWithClass:[WMWelcomeViewController class]];
    [self hideNaviTab];
}
-(void)showDefaultViewController{
    
    if ([[NKAccountManager sharedAccountsManager] canAutoLogin]) {
        [self showViewControllerWithClass:[WMHomeViewController class]];
        [self showNaviTab];
    }
    else {
        [self showWelcome];

    }
    
    
    if ([NKMUser me]) {
        
    }
    else {
        if (![[NKAccountManager sharedAccountsManager] canAutoLogin]) {
            //[self showLoginView];
        }
        else {
            [[NKAccountManager sharedAccountsManager] autoLogin];
        }
    }
    
    
}

// Show ViewController
-(UIViewController*)showViewControllerWithClass:(Class)ControllerToShow{
    
    if ([NSStringFromClass([currentController class]) isEqualToString:NSStringFromClass(ControllerToShow)]) {
        return currentController;
    }
    
    // [currentController dismissModalViewControllerAnimated:NO];
    
    UIViewController *newController = [[ControllerToShow alloc] init];
    [currentController.view removeFromSuperview];
    
    [nkBackgroundView addSubview:newController.view];
    
    self.currentController = nil;
    self.currentController = newController;
    
    [newController release];
    
    return newController;
    
}

@end
