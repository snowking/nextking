//
//  WMSettingViewController.m
//  WEIMI
//
//  Created by King on 11/14/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMSettingViewController.h"
#import "NKAccountManager.h"

@interface WMSettingViewController ()

@end

@implementation WMSettingViewController

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
    
    self.titleLabel.text = @"设置";
    
    [self addRightButtonWithTitle:@"退出"];
    
    
    
}

-(void)rightButtonClick:(id)sender{
    
    [self logout:nil];
}

-(void)logout:(id)sender{
    
    [[NKAccountManager sharedAccountsManager] logOut];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
