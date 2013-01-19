//
//  NKStatusBar.m
//  iSou
//
//  Created by King on 12-12-29.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import "NKStatusBar.h"

@implementation NKStatusBar

@synthesize messageLabel;

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = [UIApplication sharedApplication].statusBarFrame;
        self.windowLevel = UIWindowLevelStatusBar + 1.0;
        self.backgroundColor = [UIColor clearColor];
        
        self.messageLabel = [[[UILabel alloc] initWithFrame:CGRectMake(220, 0, 100, 20)] autorelease];
        messageLabel.backgroundColor = [UIColor blackColor];
        messageLabel.textAlignment = UITextAlignmentCenter;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont boldSystemFontOfSize:11];
        [self addSubview:messageLabel];
        
    }
    return self;
}



-(void)show{

    self.hidden = NO;
    self.alpha = 1.0;
}

-(void)setProgress:(float)newProgress{
    
    messageLabel.text = [NSString stringWithFormat:@"正在更新 %@", [NSNumber numberWithFloat:newProgress]];
    
}

-(void)hide{
    
    [UIView animateWithDuration:5.5 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [self autorelease];
    }];
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
