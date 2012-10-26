//
//  NKTableViewCell.m
//  ZUO
//
//  Created by King on 9/25/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewCell.h"

@implementation NKTableViewCell

@synthesize showedObject;
@synthesize bottomLine;

-(void)dealloc{
    
    [showedObject release];
    
    [super dealloc];
}


+(CGFloat)cellHeightForObject:(id)object{
    
    
    return 71;
}

-(void)showForObject:(id)object{
    
    self.showedObject = object;
    
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.bottomLine = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvLine.png"]] autorelease];
        [self.contentView addSubview:bottomLine];
        
        bottomLine.frame = CGRectMake(6, [[self class] cellHeightForObject:nil]-bottomLine.bounds.size.height, 320-12, bottomLine.bounds.size.height);
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
