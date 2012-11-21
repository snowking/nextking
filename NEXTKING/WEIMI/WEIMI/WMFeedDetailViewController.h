//
//  WMFeedDetailViewController.h
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewController.h"

@interface WMFeedDetailViewController : NKTableViewController <UIGestureRecognizerDelegate>{
    
    NKMRecord *record;
    NKInputView *commentView;
    
    
}
@property (nonatomic, retain) NKMRecord *record;
@property (nonatomic, assign) NKInputView *commentView;


+(id)feedDetailWithRecord:(NKMRecord*)theRecord;

@end
