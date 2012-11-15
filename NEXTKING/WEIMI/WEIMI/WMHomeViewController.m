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

@synthesize avatar;

-(void)dealloc{
    
    
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
    
    self.titleLabel.text = @"蜜们";
    
    
    self.avatar = [[[NKKVOImageView alloc] initWithFrame:CGRectMake(0, 44, 90, 90)] autorelease];
    [self.contentView addSubview:avatar];
    
    [avatar bindValueOfModel:[NKMUser me] forKeyPath:@"avatar"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
