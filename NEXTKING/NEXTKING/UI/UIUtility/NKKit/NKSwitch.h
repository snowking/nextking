//
//  NKSwitch.h
//  ZUO
//
//  Created by King on 9/14/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NKSwitchDelegate;

@interface NKSwitch : UIView {
    
    id <NKSwitchDelegate> delegate;
    BOOL on;
    
    
    UIImageView *handler;
    UIImageView *valuer;
    UIView      *leftBlink;
    UIView      *rightBlink;
    CGPoint leftPoint;
    CGPoint rightPoint;
    
    BOOL animating;
    
}

@property (nonatomic, assign) id <NKSwitchDelegate> delegate;
@property (nonatomic, assign) BOOL on;

@property (nonatomic, retain) UIImageView *valuer;
@property (nonatomic, retain) UIImageView *handler;

@property (nonatomic, assign) UIView      *leftBlink;
@property (nonatomic, assign) UIView      *rightBlink;

@property (nonatomic, assign) CGPoint  leftPoint;
@property (nonatomic, assign) CGPoint  rightPoint;


+(id)newSwitchWithMasker:(UIImage*)maskerImage valuer:(UIImage*)valuerImage leftBlink:(id)blinkL rightBlink:(id)blinkR leftPoint:(CGPoint)pointL rightPoint:(CGPoint)pointR andDelegate:(id<NKSwitchDelegate>)deleg;
+(id)newSwitchWithMasker:(UIImage*)maskerImage handler:(id)handlers valuer:(UIImage*)valuerImage leftBlink:(id)blinkL rightBlink:(id)blinkR leftPoint:(CGPoint)pointL rightPoint:(CGPoint)pointR andDelegate:(id<NKSwitchDelegate>)deleg;


-(void)switchOn:(BOOL)son animated:(BOOL)animated;


@end


@protocol NKSwitchDelegate <NSObject>

@optional
-(void)valueChanged:(NKSwitch*)theSwitch;

@end