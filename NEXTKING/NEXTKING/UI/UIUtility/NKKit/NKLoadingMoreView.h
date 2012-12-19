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
    NKLoadingMoreViewStyleOther
} NKLoadingMoreViewStyle;


@interface NKLoadingMoreView : UIView{
    
    UIActivityIndicatorView *indicator;
    UILabel                 *infoLabel;
    
}

@property (nonatomic, assign) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) UILabel                 *infoLabel;


+(id)loadingMoreViewWithStyle:(NKLoadingMoreViewStyle)style;

-(void)showLoading:(BOOL)loading;

@end
