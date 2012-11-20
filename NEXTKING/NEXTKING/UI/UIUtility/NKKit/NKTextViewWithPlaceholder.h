//
//  NKTextViewWithPlaceholder.h
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKTextViewWithPlaceholder : UITextView{
    
    UILabel *placeholderLabel;
}
@property (nonatomic, assign) UILabel *placeholderLabel;

-(void)textChanged:(NSNotification*)notification;

@end
