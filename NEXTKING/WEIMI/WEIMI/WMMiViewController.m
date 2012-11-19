//
//  WMMiViewController.m
//  WEIMI
//
//  Created by King on 11/19/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMMiViewController.h"

@interface WMMiViewController ()

@end

@implementation WMMiViewController
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"%@", self.user.relation);
    
    
    if ([user.relation isEqualToString:NKRelationFriend] || user == [NKMUser me]) {
        // show content
        
    }
    else if ([user.relation isEqualToString:NKRelationFollow]){
        // show Follow
        
    }
    else if ([user.relation isEqualToString:NKRelationFollower]){
        // show follower Accept or something
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
