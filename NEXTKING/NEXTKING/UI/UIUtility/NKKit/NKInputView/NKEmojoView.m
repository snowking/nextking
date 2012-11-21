//
//  NKEmojoView.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKEmojoView.h"

@implementation NKEmojoView

@synthesize textReciever;
@synthesize emojoArray;

-(void)dealloc{
    
    [emojoArray release];
    
    [super dealloc];
}


+(id)emojoViewWithReciever:(id)reciever{
    
    NKEmojoView *emojoView = [[self alloc] initWithFrame:CGRectMake(10, 49, 300, 160)];
    emojoView.textReciever = reciever;
    
    return [emojoView autorelease];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSArray *emojos = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emojo" ofType:@"plist"]];
        self.emojoArray = emojos;
        
        NSDictionary *emojo = nil;
        UIButton     *emojoButton = nil;
        
        CGFloat      currentX = 1;
        CGFloat      currentY = 12;
        
        for (int i=0; i<[emojos count]; i++) {
            emojo = [emojos objectAtIndex:i];
            
            emojoButton = [[UIButton alloc] initWithFrame:CGRectMake(currentX, currentY, 40, 41)];
            emojoButton.tag = i;
            [emojoButton setBackgroundImage:[UIImage imageNamed:@"emojoback.png"] forState:UIControlStateHighlighted];
            [emojoButton addTarget:self action:@selector(emojoClicked:) forControlEvents:UIControlEventTouchUpInside];
            [emojoButton setImage:[UIImage imageNamed:[emojo objectForKey:@"picture"]] forState:UIControlStateNormal];
            [self addSubview:emojoButton];
            [emojoButton release];
            
            currentX += 43;
            
            if (currentX>self.frame.size.width) {
                currentX = 1;
                currentY+=50;
            }
        }
    }
    return self;
}

-(void)emojoClicked:(UIButton*)button{
    
    NSDictionary *emojo = [emojoArray objectAtIndex:button.tag];
    
    [textReciever setText:[[textReciever text] length]? [[textReciever text] stringByAppendingFormat:@"%@", [emojo objectForKey:@"key"]] : [@"" stringByAppendingFormat:@"%@", [emojo objectForKey:@"key"]]];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end
