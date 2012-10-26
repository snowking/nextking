//
//  NKRequestDelegate.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKRequestDelegate.h"

@implementation NKRequestDelegate

@synthesize target;
@synthesize startSelector;
@synthesize finishSelector;
@synthesize failedSelector;


@synthesize inspector;
@synthesize finishInspectorSelector;

-(void)dealloc{
    
    [super dealloc];
}

static NSMutableArray *_requestDelegates = nil;

+(void)addRD:(NKRequestDelegate*)rd{
    
    if (!_requestDelegates) {
        _requestDelegates = [[NSMutableArray alloc] init];
    }
    
    if (rd) {
        [_requestDelegates addObject:rd];
    }
    
}

+(void)removeRD:(NKRequestDelegate*)rd{
    
    if (rd) {
        [_requestDelegates removeObject:rd];
    }
}

+(void)removeTarget:(id)tg{
    
    for (NKRequestDelegate *td in _requestDelegates) {
        if (td.target == tg) {
            td.target = nil;
        }
    }
    
}

+(id)requestDelegateWithTarget:(id)atarget finishSelector:(SEL)afinishSelector andFailedSelector:(SEL)afailedSelector{
    return [self requestDelegateWithTarget:atarget startSelector:nil finishSelector:afinishSelector andFailedSelector:afailedSelector];
}

+(id)requestDelegateWithTarget:(id)atarget startSelector:(SEL)astartSelector finishSelector:(SEL)afinishSelector andFailedSelector:(SEL)afailedSelector{
    
    NKRequestDelegate *newRequestDelegate = [[NKRequestDelegate alloc] init];
    
    newRequestDelegate.target = atarget;
    newRequestDelegate.startSelector = astartSelector;
    newRequestDelegate.finishSelector = afinishSelector;
    newRequestDelegate.failedSelector = afailedSelector;
    
    [self addRD:newRequestDelegate];
    
    return [newRequestDelegate autorelease];
    
}


-(void)delegateStartWithRequest:(id)request{
    if (target && self.startSelector) {
        [target performSelector:self.startSelector withObject:request];
    }
    else {
        [self start];
    }
    
}
-(void)delegateFinishWithRequest:(id)request{
    
    if (self.inspector && self.finishInspectorSelector && [inspector respondsToSelector:finishInspectorSelector]) {
        [inspector performSelector:finishInspectorSelector withObject:request];
    }
    
    if (target && self.finishSelector) {
        [target performSelector:self.finishSelector withObject:request];
    }
    else {
        [self success];
    }
    
    [NKRequestDelegate removeRD:self];
    
}
-(void)delegateFailedWithRequest:(id)request{
    
    if (target && self.failedSelector) {
        [target performSelector:self.failedSelector withObject:request];
    }
    else {
        [self failed];
    }
    
    [NKRequestDelegate removeRD:self];
    
}

-(void)start{
    
}

-(void)success{
    
}

-(void)failed{
    
}

@end
