//
//  NKRequestDelegate.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKRequestDelegate : NSObject{
    
    id  target;
    SEL startSelector;
    SEL finishSelector;
    SEL failedSelector;
    
    id  inspector;
    SEL finishInspectorSelector;
    
}

@property (nonatomic, assign) id  target;
@property (nonatomic, assign) SEL startSelector;
@property (nonatomic, assign) SEL finishSelector;
@property (nonatomic, assign) SEL failedSelector;

@property (nonatomic, assign) id  inspector;
@property (nonatomic, assign) SEL finishInspectorSelector;



+(id)requestDelegateWithTarget:(id)atarget startSelector:(SEL)astartSelector finishSelector:(SEL)afinishSelector andFailedSelector:(SEL)afailedSelector;

+(id)requestDelegateWithTarget:(id)atarget finishSelector:(SEL)afinishSelector andFailedSelector:(SEL)afailedSelector;


+(void)removeTarget:(id)tg;



// Tell the delegate
-(void)delegateStartWithRequest:(id)request;
-(void)delegateFinishWithRequest:(id)request;
-(void)delegateFailedWithRequest:(id)request;


// Default process if the sd has nil SEL
-(void)start;
-(void)success;
-(void)failed;

@end
