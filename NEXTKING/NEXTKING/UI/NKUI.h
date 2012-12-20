//
//  NKUI.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKKit.h"
#import "NKSDK.h"
#import "UIColor+HexString.h"
#import "NKNavigator.h"
#import "NKNavigationController.h"
#import "SKNSStringAdditions.h"

#define NKMainHeight [[UIScreen mainScreen] bounds].size.height-20
#define NKContentHeight NKMainHeight-NKNavigatorHeight

#define NKLineTableViewWidth 299

#define NKNC [[NKUI sharedNKUI] navigationController]

#define NKActionSheetStyle UIActionSheetStyleBlackTranslucent



@interface NKUI : UIViewController{
    
    
    NKNavigator *navigator;
    UIImageView *nkBackgroundView;
    
    
    UIViewController *currentController;
    
    Class welcomeCalss;
    Class homeClass;
    
    BOOL needLogin;
    
}

@property (nonatomic, assign) Class welcomeCalss;
@property (nonatomic, assign) Class homeClass;
@property (nonatomic, assign) BOOL  needLogin;

@property (nonatomic, assign) UIImageView *nkBackgroundView;
@property (nonatomic, assign) NKNavigator *navigator;

@property (nonatomic, retain) UIViewController *currentController;


+(id)sharedNKUI;

-(void)showNaviTab;

-(void)addTabs:(NSArray*)tab;

-(UIViewController*)showViewControllerWithClass:(Class)ControllerToShow;

@end
