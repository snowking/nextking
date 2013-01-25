//
//  NKPictureViewer.h
//  ZUO
//
//  Created by King on 9/17/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKKVOImageView.h"

@interface NKPictureViewer : UIView <UIScrollViewDelegate>{
    
    NKKVOImageView *imageView;
    
    CGRect startFrame;
    
    UIScrollView *myScrollView;
    
}

@property (nonatomic, retain) NKKVOImageView *imageView;
@property (nonatomic, assign) CGRect               startFrame;
@property (nonatomic, assign) UIScrollView *myScrollView;

+(id)pictureViewerWithFrame:(CGRect)frame;
+(id)pictureViewerForView:(UIView*)view;

-(void)showPictureForObject:(id)obj andKeyPath:(NSString*)path;

@end
