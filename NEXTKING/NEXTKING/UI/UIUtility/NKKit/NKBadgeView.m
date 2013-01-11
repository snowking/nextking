//
//  NKBadgeView.m
//  ZUO
//
//  Created by King on 1/11/13.
//  Copyright (c) 2013 King. All rights reserved.
//

#import "NKBadgeView.h"

@implementation NKBadgeView
@synthesize numberLabel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization
        self.clipsToBounds = NO;
        self.contentMode = UIViewContentModeScaleToFill;
        
        self.numberLabel = [[[UILabel alloc] initWithFrame:self.bounds] autorelease];
        [self addSubview:numberLabel];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.textAlignment = UITextAlignmentCenter;
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.font = [UIFont boldSystemFontOfSize:10];
        
        
        
    }
    return self;
}


-(void)render{
    
    NSNumber *number = [modelObject valueForKeyPath:theKeyPath];
    
    numberLabel.text = [NSString stringWithFormat:@"%@", [number intValue]>99?@"99+":number];
    
    self.hidden = [number intValue]<=0 ? YES: NO;
    
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
