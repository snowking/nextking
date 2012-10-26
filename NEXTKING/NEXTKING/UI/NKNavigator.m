//
//  NKNavigator.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKNavigator.h"
#import "NKUI.h"

#import "WMHomeViewController.h"
#import "WMWelcomeViewController.h"
#import "WMMenWikiViewController.h"

@implementation NKNavigator


@synthesize tabs;

-(void)dealloc{
    
    [tabs release];
    [super dealloc];
}

static NKNavigator *_navigator = nil;

+(id)sharedNavigator{
    
    if (!_navigator) {
        _navigator = [[NKNavigator alloc] initWithFrame:CGRectMake(0, NKMainHeight, 320, NKNavigatorHeight)];
    }
    return _navigator;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        
        self.tabs = [NKSegmentControl segmentControlViewWithSegments:[NSArray arrayWithObjects:
                                                                      [NKSegment segmentWithNormalBack:[UIImage imageNamed:@"homepage_normal.png"] selectedBack:[UIImage imageNamed:@"homepage_click.png"]],
                                                                      [NKSegment segmentWithNormalBack:[UIImage imageNamed:@"line_normal.png"] selectedBack:[UIImage imageNamed:@"line_click.png"]],
                                                                      
                                                                      nil]
                     
                                                         andDelegate:self];
        [self addSubview:tabs];
        tabs.frame = CGRectMake(0, 0, 320, NKNavigatorHeight);
        tabs.shouldAnimate = YES;
        
        
    }
    return self;
}


-(void)showLoginOKView{
    
    [NKNC popToRootViewControllerAnimated:NO];
    
    [self.tabs selectSegment:0 shouldTellDelegate:NO];
    
    [[NKUI sharedNKUI] showViewControllerWithClass:[UIViewController class]];
    [[NKUI sharedNKUI] showNaviTab];
}


-(void)segmentControl:(NKSegmentControl*)control didChangeIndex:(NSInteger)index{
    
    switch (index) {
        case 0:{
            [[NKUI sharedNKUI] showViewControllerWithClass:[WMHomeViewController class]];
        }
            break;
        case 1:{
            [[NKUI sharedNKUI] showViewControllerWithClass:[WMMenWikiViewController class]];
        }
            break;
            
        default:
            break;
    }
    
}

@end
