//
//  WMMenWikiViewController.m
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMMenWikiViewController.h"

@interface WMMenWikiViewController ()

@end

@implementation WMMenWikiViewController

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
    self.titleLabel.text = @"八卦百科";
    
    
    
    //[self addRecord];
    
    
}

-(void)addRecord{
    
    
    
}

-(void)addRecordOK:(NKRequest*)request{
    
    NSLog(@"%@", [request.results lastObject]);
    
}

-(void)addRecordFailed:(NKRequest*)request{
    
    NSLog(@"%@", request.errorCode);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
