//
//  ZUOCommentCell.h
//  ZUO
//
//  Created by King on 9/28/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKKit.h"
#import "NKSDK.h"

@interface ZUOCommentCell : NKTableViewCell{
    
    NKKVOImageView *avatar;
    
    UILabel        *name;
    UILabel        *time;
    UILabel        *content;
}

@property (nonatomic, assign) NKKVOImageView *avatar;

@property (nonatomic, assign) UILabel        *name;
@property (nonatomic, assign) UILabel        *time;
@property (nonatomic, assign) UILabel        *content;


@end
