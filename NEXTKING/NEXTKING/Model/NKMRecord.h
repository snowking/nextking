//
//  NKMRecord.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKModel.h"
#import "NKMUser.h"
#import "NKMAttachment.h"

@interface NKMRecord : NKModel{
    
    NKMUser  *sender;
    NSString *title;
    NSString *content;
    NSString *client;
    NSDate   *createTime;
    
    NSArray  *attachments;
    
}

@property (nonatomic, retain) NKMUser  *sender;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *client;
@property (nonatomic, retain) NSDate   *createTime;

@property (nonatomic, retain) NSArray  *attachments;

@end
