//
//  WMMiViewController.h
//  WEIMI
//
//  Created by King on 11/19/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewController.h"

@interface WMMiViewController : NKTableViewController{
    
    NKMUser *user;
}

@property (nonatomic, retain) NKMUser *user;

@end
