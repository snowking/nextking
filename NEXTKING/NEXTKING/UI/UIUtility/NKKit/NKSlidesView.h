//
//  NKSlidesView.h
//  ZUO
//
//  Created by King on 12/20/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    NKSlidesViewStyleSlides = 0,
    NKSlidesViewStyleBigImage,
    NKSlidesViewStyleDefault,
} NKSlidesViewStyle;

@interface NKSlidesView : UIView{
    
    UIScrollView *slideScrollView;
    
    NKSlidesViewStyle slidesViewStyle;
}

@property (nonatomic, assign) UIScrollView *slideScrollView;

@property (nonatomic, assign) NKSlidesViewStyle slidesViewStyle;


+(id)slidesViewWithImages:(NSArray*)images;

+(id)slidesViewWithImages:(id)images andStyle:(NKSlidesViewStyle)style;

//-(void)addButtonWith


@end
