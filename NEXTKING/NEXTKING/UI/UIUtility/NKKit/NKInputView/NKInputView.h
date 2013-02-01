//
//  NKInputView.h
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "NKEmojoView.h"


@interface NKInputView : UIView<HPGrowingTextViewDelegate>{
    
    UITableView *upTableView;
    NSArray     *otherView;
    
    NSMutableArray *dataSource;
    
    BOOL emojoing;
    
    HPGrowingTextView *textView;
    UIButton *sendButton;
    
    NKEmojoView *emojoView;
    
    id  target;
    SEL action;
    
    UIButton *keyboardButton;
    UIButton *emojoButton;
}


@property (nonatomic, assign) UITableView    *upTableView;
@property (nonatomic, assign) NSMutableArray *dataSource;

@property (nonatomic, retain) NSArray        *otherView;

@property (nonatomic, assign) BOOL emojoing;

@property (nonatomic, assign) NKEmojoView *emojoView;

@property (nonatomic, assign) id  target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, assign) HPGrowingTextView *textView;

@property (nonatomic, assign) UIButton *emojoButton;

+(id)inputViewWithTableView:(UITableView*)tableView dataSource:(NSMutableArray*)data otherView:(NSArray*)views;

-(void)hide;

-(void)sendOK;




@end
