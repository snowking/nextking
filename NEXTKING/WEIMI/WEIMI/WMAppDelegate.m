//
//  WMAppDelegate.m
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMAppDelegate.h"
#import "NKUI.h"
#import "WMHomeViewController.h"
#import "WMWelcomeViewController.h"
#import "WMMenWikiViewController.h"
#import "WMSettingViewController.h"

@implementation WMAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    
    [[NKConfig sharedConfig] setDomainURL:@"http://zhenghua.sinaapp.com/index.php"];
    
    NKUI *ui = [NKUI sharedNKUI];
    ui.needLogin = YES;
    ui.homeClass = [WMHomeViewController class];
    ui.welcomeCalss = [WMWelcomeViewController class];
    
    [ui addTabs:[NSArray arrayWithObjects:[NSArray arrayWithObjects:
                                           [NKSegment segmentWithNormalBack:[UIImage imageNamed:@"homepage_normal.png"] selectedBack:[UIImage imageNamed:@"homepage_click.png"]],
                                           [NKSegment segmentWithNormalBack:[UIImage imageNamed:@"line_normal.png"] selectedBack:[UIImage imageNamed:@"line_click.png"]],
                                           [NKSegment segmentWithNormalBack:[UIImage imageNamed:@"line_normal.png"] selectedBack:[UIImage imageNamed:@"line_click.png"]],
                                           nil],
                 [NSArray arrayWithObjects:[WMHomeViewController class], [WMMenWikiViewController class], [WMSettingViewController class], nil],
                 nil]];
    
    UINavigationController *navi = [[[UINavigationController alloc] initWithRootViewController:ui] autorelease];
    
    navi.view.backgroundColor = [UIColor clearColor];
    //navi.supportedInterfaceOrientations =
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, NKMainHeight)];
    back.image = [[UIImage imageNamed:@"appBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 50, 100, 50)];
    [navi.view insertSubview:back atIndex:0];
    [back release];
    [navi setNavigationBarHidden:YES];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end