//
//  NKTextViewWithPlaceholder.m
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTextViewWithPlaceholder.h"

@implementation NKTextViewWithPlaceholder

@synthesize placeholderLabel;


- (id)initWithFrame:(CGRect)frame{
    if((self = [super initWithFrame:frame])){
        
        self.placeholderLabel = [[[UILabel alloc] initWithFrame:CGRectMake(8,8,200,20)] autorelease];
        placeholderLabel.font = self.font;
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.hidden = NO;
        [self addSubview:placeholderLabel];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

-(void)setFont:(UIFont *)afont{
    
    [super setFont:afont];
    placeholderLabel.font = afont;
}

-(void)setText:(NSString *)atext{
    
    [super setText:atext];
    
    [self textChanged:nil];
    
}

- (void)textChanged:(NSNotification *)notification{
    
    placeholderLabel.hidden = NO;
    
    if([[self text] length])
        placeholderLabel.hidden = YES;
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

@end
