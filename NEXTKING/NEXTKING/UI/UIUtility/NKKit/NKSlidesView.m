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

@synthesize slidesViewStyle;


+(id)slidesViewWithImages:(NSArray*)images{
    
    
    return [self slidesViewWithImages:images andStyle:NKSlidesViewStyleSlides];
    
    
    
    
    
}


+(id)slidesViewWithImages:(id)images andStyle:(NKSlidesViewStyle)style{
    
    
    UIWindow *topWindow = [[[UIApplication sharedApplication] windows] lastObject];
    
    NKSlidesView *sliesView = [[self alloc] initWithFrame:topWindow.bounds];
    
    sliesView.slidesViewStyle = style;
    
    [sliesView addImages:images];
    
    [topWindow addSubview:sliesView];
    
    return [sliesView autorelease];
    
    
}


-(void)addImages:(id)images{
    
    switch (self.slidesViewStyle) {
        case NKSlidesViewStyleSlides:{
            if (!self.slideScrollView) {
                self.slideScrollView = [[[UIScrollView alloc] initWithFrame:self.bounds] autorelease];
                [self addSubview:slideScrollView];
                slideScrollView.pagingEnabled = YES;
                slideScrollView.showsHorizontalScrollIndicator = NO;
                slideScrollView.showsVerticalScrollIndicator = NO;
            }
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
            break;
        case NKSlidesViewStyleBigImage:{
            
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[images anyObject]];
            [self addSubview:imageView];
            [imageView release];
            
            CGRect imageViewFrame = imageView.frame;
            imageViewFrame.origin.x -= (imageViewFrame.size.width-self.frame.size.width)/2;
            imageViewFrame.origin.y -= (imageViewFrame.size.height-self.frame.size.height)/3;
            
            [UIView animateWithDuration:4.0 delay:0.5 options:UIViewAnimationCurveLinear animations:^{
                imageView.frame = imageViewFrame;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                } completion:^(BOOL finished) {
                    [self hide:nil];
                }];
                
                
            }];
            
            
        }
            break;
        default:
            break;
    }
    
    
    
    

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
