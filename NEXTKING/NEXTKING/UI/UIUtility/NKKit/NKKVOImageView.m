//
//  NKKVOImageView.m
//  ZUO
//
//  Created by King on 8/16/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKKVOImageView.h"

@implementation NKKVOImageView

@synthesize modelObject;
@synthesize theKeyPath;

@synthesize target;
@synthesize renderMethod;
@synthesize singleTapped;



-(void)dealloc{
    
    [modelObject removeObserver:self forKeyPath:theKeyPath];
    [modelObject release];
    [theKeyPath release];
    
    [super dealloc];
}

-(void)bindValueOfModel:(id)mo forKeyPath:(NSString*)key{
    self.image = nil;
    [modelObject removeObserver:self forKeyPath:theKeyPath];
    
    self.modelObject = mo;
    self.theKeyPath = key;
    
    [self render];
    
    [modelObject addObserver:self forKeyPath:theKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
}

-(UIImage*)renderedImageWithImage:(UIImage*)image{
    
    return image;
}

-(void)render{
    
    UIImage *downLoadImage = [modelObject valueForKeyPath:theKeyPath];
    
    if (target&&renderMethod&&[target respondsToSelector:renderMethod]) {
        self.image = [target performSelector:renderMethod withObject:downLoadImage];
    }
    else if (downLoadImage) {
        self.image = downLoadImage;
    }
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    [self render];
}

-(void)setSingleTapped:(SEL)tsingleTapped{
    
    singleTapped = tsingleTapped;
    
    self.userInteractionEnabled = YES;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:tap];
        [tap release];

    }
    return self;
}

-(void)tapped:(UITapGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if ([target respondsToSelector:singleTapped]) {
            [target performSelector:singleTapped withObject:gesture];
        }
    }
    
}


@end