//
//  NKTableViewCell.h
//  ZUO
//
//  Created by King on 9/25/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKTableViewCell : UITableViewCell{
    
    id showedObject;
     
    UIImageView      *bottomLine;
}
@property (nonatomic, retain) id showedObject;

@property (nonatomic, assign) UIImageView *bottomLine;


+(CGFloat)cellHeightForObject:(id)object;

-(void)showForObject:(id)object;


@end
