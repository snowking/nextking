//
//  WMManDetailViewController.m
//  WEIMI
//
//  Created by King on 11/22/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMManDetailViewController.h"

@interface WMManDetailViewController ()

@end

@implementation WMManDetailViewController

@synthesize record;

-(void)dealloc{
    
    [record release];
    [super dealloc];
}

+(id)manDetailWithRecord:(NKMRecord*)arecord{
    
    WMManDetailViewController *manDetail = [[self alloc] init];
    manDetail.record = arecord;
    
    [NKNC pushViewController:manDetail animated:YES];
    [manDetail release];
    
    return manDetail;

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
    
    [self addBackButton];
    
    self.titleLabel.text = record.man.showName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
