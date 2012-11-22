//
//  WMMenCell.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMMenCell.h"

@implementation WMMenCell

-(void)showForObject:(id)object{
    
    self.showedObject = object;
    
    
    NKMRecord *record = object;
    
    
    self.textLabel.text = record.man.showName;
    self.detailTextLabel.text = [[[record.man.rate objectAtIndex:0] allKeys] lastObject];
    
    [picture bindValueOfModel:[record.attachments lastObject] forKeyPath:@"picture"];
    
    
    
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
