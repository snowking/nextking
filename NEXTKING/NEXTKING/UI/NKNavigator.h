//
//  NKNavigator.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NKSegmentControl.h"

#define NKNavigatorHeight 49

@interface NKNavigator : UIView <NKSegmentControlDelegate>{
    
    
    NKSegmentControl *tabs;
    
    NSArray *tabSource;
}

@property (nonatomic, retain) NKSegmentControl *tabs;
@property (nonatomic, retain) NSArray *tabSource;

+(id)sharedNavigator;

-(void)showLoginOKView;

-(void)addTabs:(NSArray*)tab;

@end

