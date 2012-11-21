//
//  WMFeedDetailViewController.h
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewController.h"

@interface WMFeedDetailViewController : NKTableViewController{
    
    NKMRecord *record;
}
@property (nonatomic, retain) NKMRecord *record;


+(id)feedDetailWithRecord:(NKMRecord*)theRecord;

@end
