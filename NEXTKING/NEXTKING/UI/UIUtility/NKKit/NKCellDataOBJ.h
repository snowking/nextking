//
//  NKCellDataOBJ.h
//  ZUO
//
//  Created by King on 9/12/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NKCellDataOBJ : NSObject{
    
    NSString *title;
    id accessoryView; // (NSNumber or UIView)
    NSString *detailText;
    UIImage *titleImage;
    
    SEL action;
    
    id  target;
    SEL detailTextRenderMethod;
    
    NSString *keyPath;
    
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIImage *titleImage;
@property (nonatomic, retain) id accessoryView;
@property (nonatomic, retain) NSString *detailText;

@property (nonatomic, assign) SEL action;

@property (nonatomic, assign) id  target;
@property (nonatomic, assign) SEL detailTextRenderMethod;

@property (nonatomic, retain) NSString *keyPath;

+(id)cellDataOBJWithTitle:(NSString*)cellTitle detailText:(NSString*)cellDetailText accessoryView:(id)cellAccessoryView action:(SEL)cellAction;
+(id)cellDataOBJWithTitle:(NSString*)cellTitle titleImage:(UIImage*)cellTitleImage detailText:(NSString*)cellDetailText accessoryView:(id)cellAccessoryView action:(SEL)cellAction;

-(void)addSwithWithKeyPath:(NSString*)key;

@end
