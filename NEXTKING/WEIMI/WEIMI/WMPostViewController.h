//
//  WMPostViewController.h
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKViewController.h"

extern NSString *const NKAddFeedOKNotificationKey;


@interface WMPostViewController : NKViewController<UITextViewDelegate>{
    
    NKTextViewWithPlaceholder *content;
    NKMRecord *parent;
    
    NSString *type;
}


@property (nonatomic, assign) NKTextViewWithPlaceholder *content;

@property (nonatomic, retain) NKMRecord *parent;
@property (nonatomic, retain) NSString *type;


@end
