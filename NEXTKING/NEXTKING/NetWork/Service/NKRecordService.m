//
//  NKRecordService.m
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKRecordService.h"

@implementation NKRecordService

-(void)dealloc{
    [super dealloc];
}

$singleService(NKRecordService, @"record");


#pragma mark Add
static NSString *const NKAPIAddRecord = @"/add";

-(NKRequest*)addRecordWithTitle:(NSString*)title content:(NSString*)content picture:(NSData*)picture parentID:(NSString*)parentID type:(NSString*)type andRequestDelegate:(NKRequestDelegate*)rd{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIAddRecord];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMRecord class] resultType:NKResultTypeSingleObject andResultKey:@""];
    if (title) {
        [newRequest addPostValue:title forKey:@"title"];
    }
    if (type) {
        [newRequest addPostValue:type forKey:@"type"];
    }
    if (content) {
        [newRequest addPostValue:content forKey:@"content"];
    }
    if (parentID) {
        [newRequest addPostValue:parentID forKey:@"parent_id"];
    }
    
    if (picture) {
        [newRequest addData:picture withFileName:@"fromIphone.jpg" andContentType:@"image/jpeg" forKey:@"picture"];
    }
    
    [self addRequest:newRequest];
    return newRequest;
    
}

static NSString *const NKAPIListRecordWithUID = @"/user_list";
-(NKRequest*)listRecordWithUID:(NSString*)uid offset:(int)offset size:(int)size andRequestDelegate:(NKRequestDelegate*)rd{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIListRecordWithUID];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMRecord class] resultType:NKResultTypeResultSets andResultKey:@""];
    
    if (uid) {
        [newRequest addPostValue:uid forKey:@"id"];
    }
    if (offset) {
        [newRequest addPostValue:[NSNumber numberWithInt:offset] forKey:@"offset"];
    }
    if (size) {
        [newRequest addPostValue:[NSNumber numberWithInt:size] forKey:@"size"];
    }
    
    [self addRequest:newRequest];
    return newRequest;

}

static NSString *const NKAPIListRecordWithPID = @"/children_list";
-(NKRequest*)listRecordWithPID:(NSString*)pid offset:(int)offset size:(int)size andRequestDelegate:(NKRequestDelegate*)rd{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIListRecordWithPID];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMRecord class] resultType:NKResultTypeResultSets andResultKey:@""];
    
    if (pid) {
        [newRequest addPostValue:pid forKey:@"id"];
    }
    if (offset) {
        [newRequest addPostValue:[NSNumber numberWithInt:offset] forKey:@"offset"];
    }
    if (size) {
        [newRequest addPostValue:[NSNumber numberWithInt:size] forKey:@"size"];
    }
    
    [self addRequest:newRequest];
    return newRequest;

    
}


@end
