//
//  NKImagePickerView.m
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKImagePickerView.h"

@implementation NKImagePickerView

@synthesize buttonContainer;
@synthesize preContainer;
@synthesize imagePreview;
@synthesize photoButton;
@synthesize albumButton;


+(id)imagePickerViewForView:(UIView*)view{
    
    NKImagePickerView *picker = [[self alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    
    
    return [picker autorelease];
}

-(IBAction)takePhoto:(id)sender{
    
}
-(IBAction)album:(id)sender{
    
    
}

-(IBAction)cleanPhoto:(id)sender{
    
    
}
-(IBAction)preViewPhoto:(id)sender{
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
