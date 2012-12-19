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
    
    switch (style) {
        case NKLoadingMoreViewStyleDefault:
            
            break;
            
        default:
            break;
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
    
   infoLabel.text = loading? @"载入中...":@"更多内容";
    if (loading) {
        [indicator startAnimating];
    }
    else{
        [indicator stopAnimating];
    }
    
    
    
    
}


@end
