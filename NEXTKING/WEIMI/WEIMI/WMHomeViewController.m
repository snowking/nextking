//
//  WMHomeViewController.m
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMHomeViewController.h"

@interface WMHomeViewController ()

@end

@implementation WMHomeViewController

@synthesize avatarContainer;
@synthesize contentContainer;

@synthesize inviteViewController;
@synthesize miViewController;


-(void)dealloc{
    
    [inviteViewController release];
    [miViewController release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [headBar removeFromSuperview];
    headBar = nil;
    
    self.contentContainer = [[[UIView alloc] initWithFrame:self.contentView.bounds] autorelease];
    [self.contentView addSubview:contentContainer];
    
    self.dataSource = [NSMutableArray arrayWithObjects:[NKMUser me], nil];
    self.avatarContainer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)] autorelease];
    [self.contentView addSubview:avatarContainer];
    [self showFriends];
    [self listFriends];
    
    
    
    [self showContentWithUser:[NKMUser me]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Get Friends

-(void)tapped:(UITapGestureRecognizer*)gesture{
    
    NKKVOImageView *view = (NKKVOImageView *)[gesture view];
    NKMUser *user = [view modelObject];
    [self showContentWithUser:user];
}

-(void)showContentWithUser:(NKMUser*)user{
    
    if (self.miViewController.user == user) {
        return;
    }
    [[contentContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.miViewController = nil;
    self.inviteViewController = nil;
    self.miViewController = [[[WMMiViewController alloc] init] autorelease];
    miViewController.user = user;
    miViewController.view.frame = self.view.bounds;
    [contentContainer addSubview:miViewController.view];
    
}

-(void)showFriends{
    
    
    [[avatarContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 44 + 8
    
    CGFloat startX = 8;
    CGFloat avatarDistance = 8;
    CGFloat avatarWidth = 44;
    
    NKKVOImageView *avatar = nil;

    
    for (NKMUser *user in self.dataSource) {
        avatar = [[NKKVOImageView alloc] initWithFrame:CGRectMake(startX, avatarDistance, avatarWidth, avatarWidth)];
        [avatar bindValueOfModel:user forKeyPath:@"avatar"];
        [avatarContainer addSubview:avatar];
        [avatar release];
        
        avatar.target = self;
        avatar.singleTapped = @selector(tapped:);
        
        startX += avatarDistance+avatarWidth;
    }
    
    if ([self.dataSource count]<6) {
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(startX, avatarDistance, avatarWidth, avatarWidth)];
        [addButton setTitle:@"添加" forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
        [avatarContainer addSubview:addButton];
        [addButton release];
    }

}

-(void)addFriend{
    
    if (self.inviteViewController) {
        return;
    }
    
    [[contentContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.miViewController = nil;
    self.inviteViewController = nil;
    
    self.inviteViewController = [[[WMInviteMiViewController alloc] init] autorelease];
    inviteViewController.delegate = self;
    inviteViewController.view.frame = self.view.bounds;
    [contentContainer addSubview:inviteViewController.view];
    
}

-(void)inviteController:(WMInviteMiViewController*)controller didInviteUser:(NKMUser*)user{
    
    if ([self.dataSource containsObject:user]) {
      
    }
    else{
        [self.dataSource addObject:user];
        [self showFriends];

    }
    [self showContentWithUser:user];
    
}

-(void)listFriends{
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(listFriendsOK:) andFailedSelector:@selector(listFriendsFailed:)];
    [[NKUserService sharedNKUserService] listFriendsWithUID:nil andRequestDelegate:rd];
    
}

-(void)listFriendsOK:(NKRequest*)request{
    
    NSLog(@"%@", request.results);
    
    self.dataSource = [NSMutableArray arrayWithArray:request.results];
    [self.dataSource insertObject:[NKMUser me] atIndex:0];
    
    [self showFriends];
    
}

-(void)listFriendsFailed:(NKRequest*)request{
    
    
}

@end
