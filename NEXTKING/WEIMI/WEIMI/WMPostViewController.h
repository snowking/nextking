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

    
}


@property (nonatomic, assign) NKTextViewWithPlaceholder *content;


@end
