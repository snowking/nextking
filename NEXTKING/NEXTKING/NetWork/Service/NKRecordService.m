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
-(NKRequest*)addRecordWithTitle:(NSString*)title content:(NSString*)content picture:(NSData*)picture andRequestDelegate:(NKRequestDelegate*)rd{
    
    return [self addRecordWithTitle:title content:content picture:picture parentID:nil andRequestDelegate:rd];
}

-(NKRequest*)addRecordWithTitle:(NSString*)title content:(NSString*)content picture:(NSData*)picture parentID:(NSString*)parentID andRequestDelegate:(NKRequestDelegate*)rd{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self serviceBaseURL], NKAPIAddRecord];
    
    NKRequest *newRequest = [NKRequest postRequestWithURL:[NSURL URLWithString:urlString] requestDelegate:rd resultClass:[NKMRecord class] resultType:NKResultTypeSingleObject andResultKey:@""];
    if (title) {
        [newRequest addPostValue:title forKey:@"title"];
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

@end
