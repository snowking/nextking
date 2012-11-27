//
//  NKNumberPad.m
//  MomoHelper
//
//  Created by King on 11/27/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKNumberPad.h"
#import <QuartzCore/QuartzCore.h>

@implementation NKNumberPad

@synthesize textField;

@synthesize target;
@synthesize okAction;

-(void)dealloc{
    
    
    [super dealloc];
}

+(id)numberPadForTextField:(UITextField*)field{
    
    
    NKNumberPad *numberPad = [[self alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    numberPad.textField = field;
    return [numberPad autorelease];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        UIButton *button = nil;
        CGFloat startX = 0;
        CGFloat startY = 0;
        CGFloat buttonWidth = 80;
        CGFloat buttonHeight = 50;
        
        for (int i=0; i<9; i++) {
            button = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, buttonWidth, buttonHeight)];
            [button setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(addNumber:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [button release];
            startX+=buttonWidth;
            
            if (startX>=240) {
                startX = 0;
                startY+=buttonHeight;
            }
        }
        
        startX = 240;
        startY = 0;
        button = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, buttonWidth, buttonHeight)];
        [button setTitle:@"<-" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(deleteOne:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button release];
        
        startX = 240;
        startY = 50;
        button = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, buttonWidth, buttonHeight)];
        [button setTitle:@"C" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button release];
        
        startX = 0;
        startY = 150;
        button = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, buttonWidth, buttonHeight)];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button release];
        
        startX = 80;
        startY = 150;
        button = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, buttonWidth, buttonHeight)];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addNumber:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button release];
        
        startX = 160;
        startY = 150;
        button = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, buttonWidth, buttonHeight)];
        [button setTitle:@"." forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addNumber:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button release];
        
        startX = 240;
        startY = 100;
        button = [[UIButton alloc] initWithFrame:CGRectMake(startX, startY, buttonWidth, buttonHeight*2)];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ok:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button release];
        
        
        for (UIButton *button in [self subviews]) {
            button.layer.borderWidth = 1.0;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        }
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark Actions


-(void)addNumber:(UIButton*)button{
    
    
    NSString *string = [button titleForState:UIControlStateNormal];
    
    if ([string isEqualToString:@"."] && [textField.text rangeOfString:string].length) {
        return;
    }
    
    
    textField.text = textField.text ? [textField.text stringByAppendingString:string] : string;
}

-(void)hide:(id)sender{
    
    [self.textField resignFirstResponder];
}

-(void)ok:(id)sender{
    
    if ([target respondsToSelector:okAction]) {
        [target performSelector:okAction];
    }
    [self hide:nil];
}

-(void)clear:(id)sender{
    
    self.textField.text = @"";
    
}
-(void)deleteOne:(id)sender{
    
    self.textField.text = [textField.text length]?[textField.text substringToIndex:MAX(0, [textField.text length]-1)]:@"";
}

@end
