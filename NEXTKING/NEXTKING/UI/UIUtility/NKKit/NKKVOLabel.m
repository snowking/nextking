//
//  NKKVOLabel.m
//  LWUI
//
//  Created by King Connect on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NKKVOLabel.h"

@implementation NKKVOLabel

@synthesize modelObject;
@synthesize theKeyPath;

@synthesize target;
@synthesize renderMethod;
@synthesize singleTapped;

@synthesize tap;

-(void)dealloc{
    
    [modelObject removeObserver:self forKeyPath:theKeyPath];
    [modelObject release];
    [theKeyPath release];
    
    [super dealloc];
}

-(void)bindValueOfModel:(id)mo forKeyPath:(NSString*)key{
    [modelObject removeObserver:self forKeyPath:theKeyPath];
    
    self.modelObject = mo;
    self.theKeyPath = key;
    
    [self bindText];

    [modelObject addObserver:self forKeyPath:theKeyPath options:NSKeyValueObservingOptionNew context:nil];

}

-(void)bindText{

    id value = [modelObject valueForKeyPath:theKeyPath];
    
    if (target&&renderMethod&&[target respondsToSelector:renderMethod]) {
        self.text = [target performSelector:renderMethod withObject:value];
    }
    else {
        self.text = value?[NSString stringWithFormat:@"%@", value]:nil;
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self bindText];   
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
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

-(void)setSingleTapped:(SEL)tsingleTapped{
    
    singleTapped = tsingleTapped;
    
    self.userInteractionEnabled = YES;
    
    if (!self.tap) {
        self.tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)] autorelease];
        [self addGestureRecognizer:tap];
        
    }
    
}

-(void)tapped:(UITapGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if ([target respondsToSelector:singleTapped]) {
            [target performSelector:singleTapped withObject:gesture];
        }
    }
    
}

@end
