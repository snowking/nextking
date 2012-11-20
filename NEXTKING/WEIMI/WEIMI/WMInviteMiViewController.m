//
//  WMInviteMiViewController.m
//  WEIMI
//
//  Created by King on 11/19/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMInviteMiViewController.h"

@interface WMInviteMiViewController ()

@end

@implementation WMInviteMiViewController

@synthesize email;
@synthesize delegate;

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
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
//    [self.contentView addGestureRecognizer:tap];
//    [tap release];
    
    
}

-(void)tapped:(UIGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [email resignFirstResponder];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Invite

-(IBAction)invite:(id)sender{
    
    if (![email.text length]) {
        return;
    }

    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(inviteOK:) andFailedSelector:@selector(inviteFailed:)];

    [[NKUserService sharedNKUserService] inviteUserWithEmail:email.text andRequestDelegate:rd];
}

-(void)inviteOK:(NKRequest*)request{

    if ([delegate respondsToSelector:@selector(inviteController:didInviteUser:)]) {
        [delegate inviteController:self didInviteUser:[request.results lastObject]];
    }
    
    
}
-(void)inviteFailed:(NKRequest*)request{
    
    
}
@end
