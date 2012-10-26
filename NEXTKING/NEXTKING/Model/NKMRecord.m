//
//  NKMRecord.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKMRecord.h"


@implementation NKMRecord

@synthesize sender;
@synthesize title;
@synthesize content;
@synthesize client;
@synthesize createTime;

@synthesize attachments;

-(void)dealloc{
    
    [sender release];
    [title release];
    [content release];
    [client release];
    [createTime release];
    
    [attachments release];

    [super dealloc];
}



+(id)modelFromDic:(NSDictionary*)dic{
    
    NKMRecord *newRecord = [super modelFromDic:dic];
    
    newRecord.sender = [NKMUser userFromDic:[dic objectOrNilForKey:@"sender"]];
    
    NKBindValueWithKeyForParameterFromDic(@"title", newRecord.title, dic);
    NKBindValueWithKeyForParameterFromDic(@"content", newRecord.content, dic);
    NKBindValueWithKeyForParameterFromDic(@"client", newRecord.client, dic);
    
    newRecord.createTime = [NSDate dateWithTimeIntervalSince1970:[[dic objectOrNilForKey:@"create_time"] longLongValue]];
    

    // Attachments
    NSArray *tattach = [dic objectOrNilForKey:@"attachments"];
    if ([tattach count]) {
        NSMutableArray *attacht = [NSMutableArray arrayWithCapacity:[tattach count]];
        
        for (NSDictionary *tatt in tattach) {
            [attacht addObject:[NKMAttachment modelFromDic:tatt]];
        }
        newRecord.attachments = attacht;
    }
    
    
    return newRecord;
}




@end
