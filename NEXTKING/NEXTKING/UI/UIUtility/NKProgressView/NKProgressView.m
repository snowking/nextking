//
//  NKProgressView.m
//  ZUO
//
//  Created by King on 12/10/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKProgressView.h"

@implementation NKProgressView

+(id)progressViewForView:(UIView*)view{
    
    
    NKProgressView *newView = [[self alloc] initWithView:view];
    newView.removeFromSuperViewOnHide = YES;
    [view addSubview:newView];
    [newView show:YES];
    return [newView autorelease];
    
}
+(id)progressView{
    
    UIWindow *topWindow = [[[UIApplication sharedApplication] windows] lastObject];
    
    return [self progressViewForView:topWindow];
    
}
+(id)loadingViewForView:(UIView*)view{
    
    NKProgressView *progress = [self progressViewForView:view];
    progress.labelText = @"正在载入";
    return progress;
    
}
-(id)successWithString:(NSString*)string{
    
    self.labelText = string;
    self.minSize = CGSizeMake(125, 0);
    self.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emojo_weixiao.png"]] autorelease];
    // Set custom view mode
    self.mode = MBProgressHUDModeCustomView;
    [self hide:YES afterDelay:0.8];
    return nil;
    
}

-(id)failedWithString:(NSString*)string{
    
    self.labelText = string;
    self.minSize = CGSizeMake(125, 0);
    self.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emojo_ku.png"]] autorelease];
    // Set custom view mode
    self.mode = MBProgressHUDModeCustomView;
    [self hide:YES afterDelay:0.8];
    return nil;
    
}

-(id)netWorkError{
    
    return [self failedWithString:@"网络未连接，请检查设置"];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:tap];
        [tap release];
        
    }
    return self;
}

-(void)forceHide{
    
    self.hidden = YES;
}

-(void)tapped:(UITapGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [self performSelector:@selector(forceHide) withObject:nil afterDelay:10.0];
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

@end
