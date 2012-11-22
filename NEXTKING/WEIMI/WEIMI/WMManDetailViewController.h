//
//  WMManDetailViewController.h
//  WEIMI
//
//  Created by King on 11/22/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewController.h"

@interface WMManDetailViewController : NKTableViewController{
    
    NKMRecord *record;
}

@property (nonatomic, retain) NKMRecord *record;

+(id)manDetailWithRecord:(NKMRecord*)arecord;


@end
