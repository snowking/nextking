//
//  NKSlidesView.h
//  ZUO
//
//  Created by King on 12/20/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKSlidesView : UIView{
    
    UIScrollView *slideScrollView;
}

@property (nonatomic, assign) UIScrollView *slideScrollView;


+(id)slidesViewWithImages:(NSArray*)images;

//-(void)addButtonWith


@end
