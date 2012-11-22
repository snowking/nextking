//
//  NKMRecord.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKMRecord.h"


NSString *const NKRecordTypeFeed = @"feed";
NSString *const NKRecordTypeGroup = @"group";

@implementation NKMRecord

@synthesize sender;
@synthesize title;
@synthesize content;
@synthesize client;
@synthesize createTime;

@synthesize type;

@synthesize attachments;

@synthesize man;

-(void)dealloc{
    
    [sender release];
    [title release];
    [content release];
    [client release];
    [createTime release];
    
    [type release];
    
    [attachments release];
    
    [man release];

    [super dealloc];
}



+(id)modelFromDic:(NSDictionary*)dic{
    
    NKMRecord *newRecord = [super modelFromDic:dic];
    
    newRecord.sender = [NKMUser userFromDic:[dic objectOrNilForKey:@"user"]];
    
    NKBindValueWithKeyForParameterFromDic(@"title", newRecord.title, dic);
    NKBindValueWithKeyForParameterFromDic(@"content", newRecord.content, dic);
    NKBindValueWithKeyForParameterFromDic(@"client", newRecord.client, dic);
    NKBindValueWithKeyForParameterFromDic(@"type", newRecord.type, dic);
    
    
    
    
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
    
    
    if ([newRecord.type isEqualToString:NKRecordTypeGroup]) {
        NSDictionary *man = [[newRecord.content stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""] objectFromJSONString];
        if (man) {
            newRecord.man = [NKMUser user];
            newRecord.man.name = [man objectOrNilForKey:@"name"];
            newRecord.man.showName = [man objectOrNilForKey:@"showName"];
            newRecord.man.birthday = [man objectOrNilForKey:@"birthday"];
            newRecord.man.sign = [man objectOrNilForKey:@"tags"];
            newRecord.man.rate = [[[[newRecord.attachments lastObject] description] stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""] objectFromJSONString];
            newRecord.man.avatarPath = [[newRecord.attachments lastObject] pictureURL];
        }
        
        
    }
    
    
    return newRecord;
}




@end
