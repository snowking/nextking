//
//  WMFeedCell.m
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMFeedCell.h"
#import "NKModelDefine.h"
#import "NKDateUtil.h"

@implementation WMFeedCell

@synthesize picture;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.picture = [[[NKKVOImageView alloc] initWithFrame:CGRectMake(220, 0, 100, [WMFeedCell cellHeightForObject:nil])] autorelease];
        picture.contentMode = UIViewContentModeScaleAspectFill;
        picture.clipsToBounds = YES;
        [self.contentView addSubview:picture];
        
    }
    return self;
}


-(void)showForObject:(id)object{
    
    self.showedObject = object;
    
    NKMRecord *record = object;
    self.textLabel.text = [NKDateUtil intervalSinceNowWithDate:record.createTime];
    self.detailTextLabel.text = record.content;
    
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
