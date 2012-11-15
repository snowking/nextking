//
//  NKRecordService.h
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKServiceBase.h"

@interface NKRecordService : NKServiceBase

dshared(NKRecordService);

#pragma mark Add
-(NKRequest*)addRecordWithTitle:(NSString*)title content:(NSString*)content picture:(NSData*)picture andRequestDelegate:(NKRequestDelegate*)rd;
-(NKRequest*)addRecordWithTitle:(NSString*)title content:(NSString*)content picture:(NSData*)picture parentID:(NSString*)parentID andRequestDelegate:(NKRequestDelegate*)rd;



-(NKRequest*)listRecordWithUID:(NSString*)uid offset:(int)offset size:(int)size andRequestDelegate:(NKRequestDelegate*)rd;


@end
