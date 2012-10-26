//
//  NKSwitch.m
//  ZUO
//
//  Created by King on 9/14/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKSwitch.h"

@implementation NKSwitch

@synthesize delegate;
@synthesize on;

@synthesize valuer;
@synthesize handler;

@synthesize leftBlink;
@synthesize rightBlink;

@synthesize leftPoint;
@synthesize rightPoint;

-(void)dealloc{
    
    [valuer release];
    [handler release];
    
    [super dealloc];
}

-(void)switchOn:(BOOL)son animated:(BOOL)animated{
    
    
    self.on = !son;
    [self change:nil];

}


+(id)newSwitchWithMasker:(UIImage*)maskerImage handler:(id)handlers valuer:(UIImage*)valuerImage leftBlink:(id)blinkL rightBlink:(id)blinkR leftPoint:(CGPoint)pointL rightPoint:(CGPoint)pointR andDelegate:(id<NKSwitchDelegate>)deleg{
    
    UIImageView *maskView = [[UIImageView alloc] initWithImage:maskerImage];
    
    NKSwitch *newSwitch = [[NKSwitch alloc] initWithFrame:maskView.bounds];
    [newSwitch addSubview:maskView];
    [maskView release];
    
    
    UIImageView *valuerView = [[UIImageView alloc] initWithImage:valuerImage];
    newSwitch.valuer = valuerView;
    [valuerView release];
    
    [newSwitch insertSubview:valuerView belowSubview:maskView];
    
    valuerView.center = pointL;
    newSwitch.leftPoint = pointL;
    newSwitch.rightPoint = pointR;
    newSwitch.delegate = deleg;
    
    
    if ([handlers isKindOfClass:[UIImage class]]) {
        UIImageView *handlerView = [[UIImageView alloc] initWithImage:handlers];
        newSwitch.handler = handlerView;
        [handlerView release];
    }
    else if ([handlers isKindOfClass:[NSArray class]] && [handlers count]==2){
        UIImageView *handlerView = [[UIImageView alloc] initWithImage:[handlers objectAtIndex:0] highlightedImage:[handlers objectAtIndex:1]];
        newSwitch.handler = handlerView;
        [handlerView release];
    }
    if (newSwitch.handler) {
        [newSwitch insertSubview:newSwitch.handler aboveSubview:maskView];
        newSwitch.handler.center = pointL;
    }
    
    
    
    UIButton *newB = [[UIButton alloc] initWithFrame:newSwitch.bounds];
    [newB addTarget:newSwitch action:@selector(change:) forControlEvents:UIControlEventTouchDown];
    [newSwitch addSubview:newB];
    [newB release];
    
    
    if ([blinkL isKindOfClass:[UIImage class]]) {
        newSwitch.leftBlink = [[[UIImageView alloc] initWithImage:blinkL] autorelease];
        
    }
    else if ([blinkL isKindOfClass:[NSString class]]) {
        
    }
    
    [newSwitch insertSubview:newSwitch.leftBlink aboveSubview:valuerView];
    newSwitch.leftBlink.center = pointL;
    
    if ([blinkR isKindOfClass:[UIImage class]]) {
        newSwitch.rightBlink = [[[UIImageView alloc] initWithImage:blinkR] autorelease];
        
    }
    else if ([blinkR isKindOfClass:[NSString class]]) {
        
    }
    
    [newSwitch insertSubview:newSwitch.rightBlink aboveSubview:valuerView];
    newSwitch.rightBlink.center = pointR;
    newSwitch.rightBlink.alpha = 0.0;
    
    return [newSwitch autorelease];
}

+(id)newSwitchWithMasker:(UIImage*)maskerImage valuer:(UIImage*)valuerImage leftBlink:(id)blinkL rightBlink:(id)blinkR leftPoint:(CGPoint)pointL rightPoint:(CGPoint)pointR andDelegate:(id<NKSwitchDelegate>)deleg{
    
    
    return [self newSwitchWithMasker:maskerImage handler:nil valuer:valuerImage leftBlink:blinkL rightBlink:blinkR leftPoint:pointL rightPoint:pointR andDelegate:deleg];
}


-(void)change:(id)sender{
    
    
    if (animating) {
        return;
    }
    
    animating = YES;
    self.on = !self.on;
    
    [UIView animateWithDuration:0.2 animations:^{
        handler.center = on? rightPoint:leftPoint;
        valuer.center = on? rightPoint:leftPoint;
        leftBlink.alpha = on? 0.0:1.0;
        rightBlink.alpha = on? 1.0:0.0;
        handler.highlighted = YES;
        
    } completion:^(BOOL finished) {
        animating = NO;
        handler.highlighted = NO;
        
        if ([delegate respondsToSelector:@selector(valueChanged:)]) {
            [delegate valueChanged:self];
        }
        
        
    }];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
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

@end
