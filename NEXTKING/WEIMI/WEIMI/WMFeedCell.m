//
//  WMFeedCell.m
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMFeedCell.h"


@implementation WMFeedCell

@synthesize picture;

+(CGFloat)cellHeightForObject:(id)object{
    
    return 100;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        self.picture = [[[NKKVOImageView alloc] initWithFrame:CGRectMake(220, 5, 100, [WMFeedCell cellHeightForObject:nil]-10)] autorelease];
        picture.contentMode = UIViewContentModeScaleAspectFill;
        picture.clipsToBounds = YES;
        picture.target = self;
        picture.singleTapped = @selector(pictureTapped:);
        [self.contentView addSubview:picture];
        
    }
    return self;
}

-(void)pictureTapped:(UITapGestureRecognizer*)gesture{
    
    
    if ([[[self.showedObject attachments] lastObject] picture]) {
        NKPictureViewer *viewer = [NKPictureViewer pictureViewerForView:self.picture];
        [viewer showPictureForObject:[[self.showedObject attachments] lastObject] andKeyPath:@"picture"];
    }
    
    
    
}
-(void)showForObject:(id)object{
    
    self.showedObject = object;
    
    NKMRecord *record = object;
    self.detailTextLabel.text = [NKDateUtil intervalSinceNowWithDate:record.createTime];
    self.textLabel.text =  record.man ? [record.man showRate] : record.content;
    
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
