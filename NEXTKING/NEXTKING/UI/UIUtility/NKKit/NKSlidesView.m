//
//  NKSlidesView.m
//  ZUO
//
//  Created by King on 12/20/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKSlidesView.h"

@implementation NKSlidesView

@synthesize slideScrollView;


+(id)slidesViewWithImages:(NSArray*)images{
    
    
    UIWindow *topWindow = [[[UIApplication sharedApplication] windows] lastObject];
    
    NKSlidesView *sliesView = [[self alloc] initWithFrame:topWindow.bounds];
    
    
    [sliesView addImages:images];
    
    [topWindow addSubview:sliesView];
    
    return [sliesView autorelease];
    
    
    
}


-(void)addImages:(NSArray*)images{
    
    slideScrollView.contentSize = CGSizeMake(320*[images count], self.frame.size.height);
    
    CGFloat x = 0;
    UIImageView *imageView = nil;
    
    for (UIImage *image in images) {
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 320, self.frame.size.height)];
        imageView.contentMode = UIViewContentModeCenter;
        [slideScrollView addSubview:imageView];
        [imageView release];
        imageView.image = image;
        x+=320;
    }
    
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(x-320, 0, 320, self.frame.size.height)];
    [doneButton addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    [slideScrollView addSubview:doneButton];
    [doneButton release];
    

}

-(void)hide:(id)sender{
    
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor blackColor];
        
        self.slideScrollView = [[[UIScrollView alloc] initWithFrame:self.bounds] autorelease];
        [self addSubview:slideScrollView];
        slideScrollView.pagingEnabled = YES;
        slideScrollView.showsHorizontalScrollIndicator = NO;
        slideScrollView.showsVerticalScrollIndicator = NO;
        
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
