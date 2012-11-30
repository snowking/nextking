//
//  WMHomeViewController.h
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewController.h"
#import "WMInviteMiViewController.h"
#import "WMMiViewController.h"

@interface WMHomeViewController : NKTableViewController <WMInviteDelegate, WMMiViewControllerDelegate>{

    UIView *avatarContainer;
    UIView *contentContainer;
    
    WMInviteMiViewController *inviteViewController;
    WMMiViewController *miViewController;
    
    UIScrollView *bookScrollView;
    
}

@property (nonatomic, assign) UIView *avatarContainer;
@property (nonatomic, assign) UIView *contentContainer;

@property (nonatomic, retain) WMInviteMiViewController *inviteViewController;
@property (nonatomic, retain) WMMiViewController *miViewController;

@property (nonatomic, assign) UIScrollView *bookScrollView;

@end
