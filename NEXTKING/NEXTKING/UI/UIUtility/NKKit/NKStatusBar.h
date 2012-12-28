//
//  NKStatusBar.h
//  iSou
//
//  Created by King on 12-12-29.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIProgressDelegate.h"

@interface NKStatusBar : UIWindow <ASIProgressDelegate>{
    
    UILabel *messageLabel;
}

@property (nonatomic, assign) UILabel *messageLabel;

-(void)setProgress:(float)newProgress;

-(void)show;

-(void)hide;

@end
