//
//  WMRateViewController.h
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewController.h"

@interface WMRateViewController : NKTableViewController{
    
    NKMUser *man;
}

@property (nonatomic, retain) NKMUser *man;

-(void)setupUI;

@end
