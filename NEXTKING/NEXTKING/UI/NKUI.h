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


#define NKMainHeight [[UIScreen mainScreen] bounds].size.height-20
#define NKContentHeight NKMainHeight-49

#define NKLineTableViewWidth 299

#define NKNavigationController [[NKUI sharedNKUI] navigationController]
#define NKNC NKNavigationController

@class NKNavigator;

@interface NKUI : UIViewController{
    
    
    NKNavigator *navigator;
    UIImageView *nkBackgroundView;
    
    
    UIViewController *currentController;
    
}


@property (nonatomic, assign) UIImageView *nkBackgroundView;
@property (nonatomic, assign) NKNavigator *navigator;

@property (nonatomic, retain) UIViewController *currentController;


+(id)sharedNKUI;

-(void)showNaviTab;

-(UIViewController*)showViewControllerWithClass:(Class)ControllerToShow;

@end
