//
//  NKConfig.m
//  iSou
//
//  Created by King on 12-11-8.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import "NKConfig.h"

@implementation NKConfig

@synthesize navigatorHeight;
@synthesize navigatorChangeAnimate;
@synthesize navigatorShowAnimate;

@synthesize domainURL;

@synthesize parseDataKey;
@synthesize parseStatusKey;
@synthesize parseValueKey;
@synthesize successReturnValue;

@synthesize errorTarget;
@synthesize errorMethod;

-(void)dealloc{
    
    [domainURL release];
    [parseDataKey release];
    [parseStatusKey release];
    [parseValueKey release];
    
    [super dealloc];
}

static NKConfig *_config = nil;

+(id)sharedConfig{
    
    if (!_config) {
        _config = [[self alloc] init];
    }

    return _config;
}

-(id)init{
    
    
    self = [super init];
    if (self) {
        
        self.navigatorHeight = 49;
        self.navigatorChangeAnimate = YES;
        self.navigatorShowAnimate = YES;
        
        self.domainURL = @"http://127.0.0.1:8888/nextking_server/index.php";
        
        self.parseDataKey = @"data";
        self.parseStatusKey = @"status";
        self.parseValueKey = @"values";
        self.successReturnValue = 1;
        
    }
    
    return self;
}


@end
