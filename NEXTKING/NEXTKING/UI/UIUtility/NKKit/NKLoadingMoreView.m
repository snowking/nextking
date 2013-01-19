//
//  NKLoadingMoreView.m
//  ZUO
//
//  Created by King on 8/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKLoadingMoreView.h"

@implementation NKLoadingMoreView

@synthesize indicator;
@synthesize infoLabel;

@synthesize loadingMoreViewStyle;

@synthesize actionButton;

@synthesize target;
@synthesize action;


+(id)loadingMoreViewWithStyle:(NKLoadingMoreViewStyle)style{
    
    NKLoadingMoreView *loadingMoreView = [[self alloc] initWithFrame:CGRectMake(0, 0, 320, 52)];
    
    [loadingMoreView changeStyle:style];
    return [loadingMoreView autorelease];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.indicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
        [self addSubview:indicator];
        indicator.hidesWhenStopped = YES;
        indicator.center = CGPointMake(66, 26);
        
        self.infoLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 52)] autorelease];
        [self addSubview:infoLabel];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textAlignment = UITextAlignmentCenter;
        infoLabel.font = [UIFont systemFontOfSize:12];
        
        
        
    }
    return self;
}

-(void)changeStyle:(NKLoadingMoreViewStyle)style{
    
    
    self.loadingMoreViewStyle = style;
    
    switch (loadingMoreViewStyle) {
        case NKLoadingMoreViewStyleDefault:
            
            break;
            
        case NKLoadingMoreViewStyleZUO:{
            
            infoLabel.textColor = [UIColor grayColor];
            
            self.actionButton = [[[UIButton alloc] initWithFrame:self.bounds] autorelease];
            [self addSubview:actionButton];
            [actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case NKLoadingMoreViewStyleZUOAlbum:{
            
            infoLabel.textColor = [UIColor grayColor];
            indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            
            self.actionButton = [[[UIButton alloc] initWithFrame:self.bounds] autorelease];
            [self addSubview:actionButton];
            [actionButton addTarget:self action:@selector(actionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}

-(void)actionButtonClick:(id)sender{
    
    
    if ([target respondsToSelector:action]) {
        [target performSelector:action];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)showLoading:(BOOL)loading{
    
    switch (loadingMoreViewStyle) {
        case NKLoadingMoreViewStyleDefault:
            
            
            infoLabel.text = loading? @"载入中...":@"没有更多了";
            if (loading) {
                [indicator startAnimating];
            }
            else{
                [indicator stopAnimating];
            }
            
            break;
        case NKLoadingMoreViewStyleZUOAlbum:
        case NKLoadingMoreViewStyleZUO:
            
            
            infoLabel.text = loading? @"载入中...":@"点击加载更多";
            if (loading) {
                [indicator startAnimating];
            }
            else{
                [indicator stopAnimating];
            }
            actionButton.enabled = !loading;
            
            break;
            
        default:
            break;
    }
    
    
   
    
    
    
}


@end
