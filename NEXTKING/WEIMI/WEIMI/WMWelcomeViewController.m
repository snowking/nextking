//
//  WMWelcomeViewController.m
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMWelcomeViewController.h"
#import "WMLoginViewController.h"

@interface WMWelcomeViewController ()

@end

@implementation WMWelcomeViewController

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action

-(void)leftButtonClick:(id)sender{
    
    WMLoginViewController *login = [[WMLoginViewController alloc] init];
    [NKNC pushViewController:login animated:YES];
    [login release];

}


-(void)rightButtonClick:(id)sender{
    
    
    
}

@end
