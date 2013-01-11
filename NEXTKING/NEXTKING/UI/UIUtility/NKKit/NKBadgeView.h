//
//  NKBadgeView.h
//  ZUO
//
//  Created by King on 1/11/13.
//  Copyright (c) 2013 King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKKVOImageView.h"

@interface NKBadgeView : NKKVOImageView{
    
    UILabel *numberLabel;
    
}

@property (nonatomic, assign) UILabel *numberLabel;


@end
