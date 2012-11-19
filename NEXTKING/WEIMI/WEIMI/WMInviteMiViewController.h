//
//  WMInviteMiViewController.h
//  WEIMI
//
//  Created by King on 11/19/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKViewController.h"

@protocol WMInviteDelegate;

@interface WMInviteMiViewController : NKViewController{
    
    IBOutlet UITextField *email;
}

@property (nonatomic, assign) IBOutlet UITextField *email;
@property (nonatomic, assign) id <WMInviteDelegate> delegate;

-(IBAction)invite:(id)sender;

@end


@protocol WMInviteDelegate <NSObject>

@optional
-(void)inviteController:(WMInviteMiViewController*)controller didInviteUser:(NKMUser*)user;

@end


