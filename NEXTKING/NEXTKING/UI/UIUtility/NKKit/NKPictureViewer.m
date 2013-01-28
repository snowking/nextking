//
//  NKPictureViewer.m
//  ZUO
//
//  Created by King on 9/17/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKPictureViewer.h"

@implementation NKPictureViewer

@synthesize imageView;
@synthesize startFrame;
@synthesize myScrollView;

-(void)dealloc{
    
    [imageView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:tap];
        [tap release];
        
        self.myScrollView = [[[UIScrollView alloc] initWithFrame:self.bounds] autorelease];
        self.myScrollView.maximumZoomScale = 3.0;
        self.myScrollView.minimumZoomScale = 0.5;
        self.myScrollView.contentSize = self.bounds.size;
        self.myScrollView.delegate = self;
        [self addSubview:myScrollView];
        

    }
    return self;
}
#pragma mark Show


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    imageView.center = CGPointMake(MAX(imageView.frame.size.width/2, self.frame.size.width/2) , MAX(imageView.frame.size.height/2, self.frame.size.height/2));
    
}


#pragma mark Gesture


-(void)tapped:(UITapGestureRecognizer*)gesture{
    
    gesture.enabled = NO;
    
    [self addSubview:imageView];
    imageView.frame = [self convertRect:imageView.frame fromView:myScrollView];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            
            imageView.frame = startFrame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
    
}

#pragma mark Init

+(id)pictureViewerForView:(UIView*)view{
    
    
    UIImageView *imageView = (UIImageView*)view;
    
    if (!imageView.image) {
        return nil;
    }
    
    UIWindow *topWindow = [[[UIApplication sharedApplication] windows] lastObject];
    CGRect frameInWindow = [view convertRect:view.bounds toView:topWindow];

    CGSize imageSize = [[imageView image] size];
    
    if (imageSize.width/imageSize.height >= imageView.bounds.size.width/imageView.bounds.size.height) {
        
        frameInWindow.size.height = imageView.bounds.size.height;
        frameInWindow.size.width = imageSize.width/imageSize.height*imageView.bounds.size.height;
        frameInWindow.origin.x -= (frameInWindow.size.width-view.bounds.size.width)/2;
        
    }
    else {
        frameInWindow.size.width = imageView.bounds.size.width;
        frameInWindow.size.height = imageSize.height/imageSize.width*imageView.bounds.size.width;
        frameInWindow.origin.y -= (frameInWindow.size.height-view.bounds.size.height)/2;
    }

    NKPictureViewer *viewer = [NKPictureViewer pictureViewerWithFrame:frameInWindow];
    viewer.imageView.placeHolderImage = imageView.image;
    [topWindow addSubview:viewer];
    
    return viewer;
    
    
}

+(id)pictureViewerWithFrame:(CGRect)frame{
    
    CGRect boundFrame = [[UIScreen mainScreen] bounds];    
    NKPictureViewer *newViewer = [[NKPictureViewer alloc] initWithFrame: boundFrame];
    
    newViewer.alpha = 0.0;
    
    
    NKKVOImageView *imageView = [[NKKVOImageView alloc] initWithFrame:frame];
    [newViewer addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView release];
    
    newViewer.imageView = imageView;
    newViewer.startFrame = frame;
    [newViewer.myScrollView addSubview:imageView];
    return [newViewer autorelease];

}

-(void)showPictureForObject:(id)obj andKeyPath:(NSString*)path{
    
    
    [imageView bindValueOfModel:obj forKeyPath:path];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            CGRect imageViewFrame = imageView.frame;
            CGSize imageSize = [[imageView image] size];
            if (imageSize.width/imageSize.height >= self.bounds.size.width/self.bounds.size.height) {
                imageViewFrame.size.width = self.bounds.size.width;
                imageViewFrame.size.height = imageSize.height/imageSize.width*self.bounds.size.width;
            }
            else {
                imageViewFrame.size.height = self.bounds.size.height;
                imageViewFrame.size.width = imageSize.width/imageSize.height*self.bounds.size.height;
            }
            
            imageView.bounds = imageViewFrame;
            imageView.center = self.center;
            
        } completion:^(BOOL finished) {
            
        }];
        
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
