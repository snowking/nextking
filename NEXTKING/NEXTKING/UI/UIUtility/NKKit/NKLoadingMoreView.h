//
//  NKLoadingMoreView.h
//  ZUO
//
//  Created by King on 8/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    NKLoadingMoreViewStyleDefault = 0,
    NKLoadingMoreViewStyleZUO,
    NKLoadingMoreViewStyleZUOAlbum,
    NKLoadingMoreViewStyleOther
} NKLoadingMoreViewStyle;


@interface NKLoadingMoreView : UIView{
    
    UIActivityIndicatorView *indicator;
    UILabel                 *infoLabel;
    
    NKLoadingMoreViewStyle   loadingMoreViewStyle;
    
    
    UIButton                *actionButton;
    
    
    id                       target;
    SEL                      action;
    
    
}

@property (nonatomic, assign) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) UILabel                 *infoLabel;

@property (nonatomic, assign) NKLoadingMoreViewStyle   loadingMoreViewStyle;

@property (nonatomic, assign) UIButton                *actionButton;

@property (nonatomic, assign) id                       target;
@property (nonatomic, assign) SEL                      action;


+(id)loadingMoreViewWithStyle:(NKLoadingMoreViewStyle)style;

-(void)showLoading:(BOOL)loading;

@end
