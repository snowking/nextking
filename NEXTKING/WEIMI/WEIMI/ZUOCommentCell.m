//
//  ZUOCommentCell.m
//  ZUO
//
//  Created by King on 9/28/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "ZUOCommentCell.h"

#define contentFont [UIFont systemFontOfSize:12]
#define contentWidth 230



@implementation ZUOCommentCell

@synthesize avatar;
@synthesize name;
@synthesize time;
@synthesize content;

-(void)dealloc{
    
    
    
    [super dealloc];
}

+(CGFloat)cellHeightForObject:(id)object{
    
    
    NKMRecord *message = (NKMRecord *)object;
    
    CGFloat height = [message.content sizeWithFont:contentFont constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return MAX(52, height+28+9);
    
}


-(void)showForObject:(id)object{
    
    [super showForObject:object];
    NKMRecord *message = (NKMRecord *)object;
    
    [avatar bindValueOfModel:message.sender forKeyPath:@"avatar"];
    name.text = message.sender.name;
    
    time.text = [NKDateUtil intervalSinceNowWithDate:message.createTime];
    
    CGRect contentFrame = content.frame;
    contentFrame.size.height = [message.content sizeWithFont:contentFont constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    content.frame = contentFrame;
    
    content.text = message.content;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.origin.y = 0;
        bottomLine.frame = bottomLineFrame;
        bottomLine.image = nil;
        bottomLine.backgroundColor = [UIColor colorWithHexString:@"#EDF0F2"];
        
        self.avatar = [[[NKKVOImageView alloc] initWithFrame:CGRectMake(26, 10, 30, 30)] autorelease];
        [self.contentView addSubview:avatar];
//        UIImageView *shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar30.png"]];
//        shadow.frame = CGRectMake(-2, -1, 34, 34);
//        [avatar addSubview:shadow];
//        [shadow release];
        
        
        self.name = [[[UILabel alloc] initWithFrame:CGRectMake(68, 10, 180, 16)] autorelease];
        [self.contentView addSubview:name];
        name.font = [UIFont boldSystemFontOfSize:14];
        name.backgroundColor = [UIColor clearColor];
        
        
        
        self.time = [[[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 14)] autorelease];
        [self.contentView addSubview:time];
        time.textAlignment = UITextAlignmentRight;
        time.textColor = [UIColor colorWithHexString:@"#9BA1A7"];
        time.font = [UIFont systemFontOfSize:10];
        time.backgroundColor = [UIColor clearColor];
        
//        self.time = [[[UILabel alloc] initWithFrame:CGRectMake(248, 10, 50, 14)] autorelease];
//        [self.contentView addSubview:time];
//        time.font = [UIFont systemFontOfSize:12];
//        time.backgroundColor = [UIColor clearColor];
//        time.textColor = [UIColor colorWithHexString:@"#A0A0A0"];
        
        self.content = [[[UILabel alloc] initWithFrame:CGRectMake(68, 28, contentWidth, 14)] autorelease];
        [self.contentView addSubview:content];
        content.numberOfLines = 0;
        content.lineBreakMode = NSLineBreakByWordWrapping;
        content.font = contentFont;
        content.backgroundColor = [UIColor clearColor];
        content.textColor = [UIColor colorWithHexString:@"#8D8D8D"];
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
