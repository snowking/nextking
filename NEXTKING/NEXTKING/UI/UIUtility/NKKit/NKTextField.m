//
//  NKTextField.m
//  ZUO
//
//  Created by King on 9/18/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTextField.h"

@implementation NKTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = NO;
    }
    return self;
}

- (CGRect)borderRectForBounds:(CGRect)bounds{
    
    return CGRectMake(-10, 0, bounds.size.width+20, bounds.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
