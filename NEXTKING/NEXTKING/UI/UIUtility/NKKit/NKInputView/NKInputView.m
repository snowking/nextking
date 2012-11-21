//
//  NKInputView.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKInputView.h"
#import "UIColor+HexString.h"

#define InputViewHeadHeight 49
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height-20

@implementation NKInputView

@synthesize upTableView;
@synthesize dataSource;

@synthesize otherView;

@synthesize editting;

@synthesize emojoView;

@synthesize target;
@synthesize action;

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [otherView release];
    [super dealloc];
}


+(id)inputViewWithTableView:(UITableView*)tableView dataSource:(NSMutableArray*)data otherView:(NSArray*)views{
    
    
    NKInputView *inputView = [[self alloc] initWithFrame:CGRectMake(0, ScreenHeight-InputViewHeadHeight, [[UIScreen mainScreen] bounds].size.width, InputViewHeadHeight+216)];
    inputView.upTableView = tableView;
    inputView.otherView = views;
    inputView.dataSource = data;
    return [inputView autorelease];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 2.5, [[UIScreen mainScreen] bounds].size.width, 1)];
        topLine.backgroundColor = [UIColor whiteColor];
        topLine.alpha = 0.8;
        [self addSubview:topLine];
        [topLine release];
        
        UIButton *emojoButton = [self addEmojoButtonWithTitle:[NSArray arrayWithObjects:[UIImage imageNamed:@"emojo_normal.png"], [UIImage imageNamed:@"emojo_normal.png"], nil]];
        emojoButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        textView = [[[HPGrowingTextView alloc] initWithFrame:CGRectMake(46, 10.5, 209, 20)] autorelease];
        textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        
        textView.minNumberOfLines = 1;
        //textView.maxNumberOfLines = 4;
        textView.returnKeyType = UIReturnKeyDefault; //just as an example
        textView.font = [UIFont systemFontOfSize:13.0f];
        textView.delegate = self;
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        textView.internalTextView.backgroundColor = [UIColor clearColor];
        //textView.backgroundColor = [UIColor whiteColor];
        
        // textView.text = @"test\n\ntest";
        // textView.animateHeightChange = NO; //turns off animation
        
        UIImage *rawEntryBackground = [UIImage imageNamed:@"replyinputbg.png"];
        UIImage *entryBackground = [rawEntryBackground resizableImageWithCapInsets:UIEdgeInsetsMake(10, 30, 10, 30)];
        UIImageView *entryImageView = [[[UIImageView alloc] initWithImage:entryBackground] autorelease];
        entryImageView.frame = CGRectMake(46, 10, 209, 34);
        entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        
        textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        // view hierachy
        [self addSubview:entryImageView];
        [self addSubview:textView];
        
        UIImage *sendBtnBackground = [[UIImage imageNamed:@"replysend_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 15)];
        UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"replysend_click.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 15, 8, 15)];
        UIImage *disableSendBtnBackground = [[UIImage imageNamed:@"replysend_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 15, 16, 15)];
        
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(260, 10, 52, 34);
        doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [doneBtn setTitle:@"发送" forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor colorWithWhite:0.9 alpha:1] forState:UIControlStateDisabled];
        [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
        [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.3] forState:UIControlStateDisabled];
        doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
        doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        
        [doneBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
        [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
        [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateHighlighted];
        [doneBtn setBackgroundImage:disableSendBtnBackground forState:UIControlStateDisabled];
        [self addSubview:doneBtn];
        sendButton = doneBtn;
        doneBtn.enabled = NO;
        
        
        UIButton *keyboardButton = [self styleButton];
        [keyboardButton addTarget:self action:@selector(showKeyboard) forControlEvents:UIControlEventTouchUpInside];
        [keyboardButton setImage:[UIImage imageNamed:@"replykeyboard.png"] forState:UIControlStateNormal];
        keyboardButton.frame = CGRectMake(2, 218, 60, 45);
        keyboardButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        UIButton *hideButton = [self styleButton];
        [hideButton addTarget:self action:@selector(hideButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [hideButton setImage:[UIImage imageNamed:@"replyhide.png"] forState:UIControlStateNormal];
        hideButton.frame = CGRectMake(258, 218, 60, 45);
        hideButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        
        
    }
    return self;
}

-(void)showKeyboard{
    
    [textView becomeFirstResponder];
    
}

-(void)hideButtonClick{
    [self hide];
}

-(void)sendMessage{
    
    if ([target respondsToSelector:action]) {
        [target performSelector:action withObject:textView.text];
    }
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark -
#pragma mark Notifications

- (void)keyboardWillShow:(NSNotification *)note{
    
    
    if (![textView.internalTextView isFirstResponder]) {
        return;
    }
    
    editting = YES;
    
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGRect frame = self.frame;
    frame.origin.y = ScreenHeight - (keyboardBounds.size.height + self.frame.size.height-216);
    
    CGRect upFrame = upTableView.frame;
    upFrame.size.height = frame.origin.y - upFrame.origin.y;
    
    
    
    [UIView animateWithDuration:[duration doubleValue] delay:0 options:UIViewAnimationOptionBeginFromCurrentState|[curve intValue] animations:^{
        
        for (UIView *other in self.otherView) {
            if (other.frame.size.height!=upTableView.frame.size.height) {
                other.frame = CGRectMake(0, upFrame.origin.y+upFrame.size.height-other.bounds.size.height, other.frame.size.width, other.frame.size.height);
            }
            else{
                CGRect otherFrame = other.frame;
                otherFrame.size.height = upFrame.size.height;
                other.frame = otherFrame;
            }
        }
        
        self.frame = frame;
        upTableView.frame = upFrame;
        if ([dataSource count]) {
            [upTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[dataSource count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)keyboardWillHide:(NSNotification *)note{
    
    if (editting) {
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = ScreenHeight-(self.frame.size.height-216);
    CGRect upFrame = upTableView.frame;
    upFrame.size.height = frame.origin.y-upFrame.origin.y;;
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|0 animations:^{
        
        for (UIView *other in self.otherView) {
            if (other.frame.size.height!=upTableView.frame.size.height) {
                other.frame = CGRectMake(0, upFrame.origin.y+upFrame.size.height-other.bounds.size.height, other.frame.size.width, other.frame.size.height);
            }
            else{
                CGRect otherFrame = other.frame;
                otherFrame.size.height = upFrame.size.height;
                other.frame = otherFrame;
                
            }
        }
        
        self.frame = frame;
        upTableView.frame = upFrame;
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	self.frame = r;
    
    CGRect upFrame = upTableView.frame;
    upFrame.size.height = r.origin.y-upFrame.origin.y;
    for (UIView *other in self.otherView) {
        if (other.frame.size.height!=upTableView.frame.size.height) {
            other.frame = CGRectMake(0, upFrame.origin.y+upFrame.size.height-other.bounds.size.height, other.frame.size.width, other.frame.size.height);
        }
        else{
            CGRect otherFrame = other.frame;
            otherFrame.size.height = upFrame.size.height;
            other.frame = otherFrame;
            
        }
    }
    
    upTableView.frame = upFrame;
    if ([dataSource count]) {
        [upTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[dataSource count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView{
    
    
    sendButton.enabled = [growingTextView hasText];
    
    //NSLog(@"%d", [growingTextView hasText]);
    
}



-(void)hide{
    
    editting = NO;
    
    if ([textView.internalTextView isFirstResponder]) {
        [textView.internalTextView resignFirstResponder];
    }
    else{
        
        [self keyboardWillHide:nil];
    }
    
}

-(void)sendOK{
    
    textView.text = @"";
    
}

#pragma mark Emojo

-(UIButton*)styleButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normal = [[UIImage imageNamed:@"topButton_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    UIImage *highlight = [[UIImage imageNamed:@"topButton_click.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    button.frame = CGRectMake(0, 0, normal.size.width, normal.size.height);
    [button setBackgroundImage:normal forState:UIControlStateNormal];
    [button setBackgroundImage:highlight forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [button setTitleColor:[UIColor colorWithHexString:@"#4287C6"] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:button];
    [button setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    return button;
    
}

-(UIButton*)addEmojoButtonWithTitle:(id)title{
    
    UIButton *button = [self styleButton];
    [button addTarget:self action:@selector(emojoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    else if ([title isKindOfClass:[NSArray class]]){
        [button setImage:[title objectAtIndex:0] forState:UIControlStateNormal];
        [button setImage:[title objectAtIndex:1] forState:UIControlStateHighlighted];
    }
    
    button.frame = CGRectMake(2, 4, 45, 45);
    return button;
    
}

-(void)emojoButtonClick:(id)sender{
    
    editting = YES;
    
    
    if (!self.emojoView) {
        self.emojoView = [NKEmojoView emojoViewWithReciever:textView];
        emojoView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:emojoView];
    }
    
    CGRect frame = self.frame;
    frame.origin.y = ScreenHeight - self.frame.size.height;
    
    CGRect upFrame = upTableView.frame;
    upFrame.size.height = frame.origin.y - upFrame.origin.y;
    
    
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|0 animations:^{
        
        for (UIView *other in self.otherView) {
            if (other.frame.size.height!=upTableView.frame.size.height) {
                other.frame = CGRectMake(0, upFrame.origin.y+upFrame.size.height-other.bounds.size.height, other.frame.size.width, other.frame.size.height);
            }
            else{
                CGRect otherFrame = other.frame;
                otherFrame.size.height = upFrame.size.height;
                other.frame = otherFrame;
            }
        }
        
        self.frame = frame;
        upTableView.frame = upFrame;
        if ([dataSource count]) {
            [upTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[dataSource count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    [textView.internalTextView resignFirstResponder];
}


@end
