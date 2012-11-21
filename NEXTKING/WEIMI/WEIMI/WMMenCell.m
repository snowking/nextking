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
    
    self.textLabel.text = record.title;
    self.detailTextLabel.text = [[record.attachments lastObject] description];
    
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
