//
//  WMFeedCell.h
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewCell.h"
#import "NKModelDefine.h"
#import "NKDateUtil.h"
#import "NKKit.h"

@interface WMFeedCell : NKTableViewCell{
    
    
    NKKVOImageView *picture;
}

@property (nonatomic, assign) NKKVOImageView *picture;

@end
