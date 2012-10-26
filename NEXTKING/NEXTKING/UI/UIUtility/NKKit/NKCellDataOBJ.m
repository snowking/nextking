//
//  NKCellDataOBJ.m
//  ZUO
//
//  Created by King on 9/12/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKCellDataOBJ.h"

@implementation NKCellDataOBJ

@synthesize title;
@synthesize titleImage;
@synthesize accessoryView;
@synthesize detailText;

@synthesize action;

@synthesize target;
@synthesize detailTextRenderMethod;

@synthesize keyPath;


-(void)dealloc{
    
    [title release];
    [titleImage release];
    [accessoryView release];
    [detailText release];
    
    [keyPath release];
    
    [super dealloc];
}
+(id)cellDataOBJWithTitle:(NSString*)cellTitle titleImage:(UIImage*)cellTitleImage detailText:(NSString*)cellDetailText accessoryView:(id)cellAccessoryView action:(SEL)cellAction{
    NKCellDataOBJ *newCellOBJ = [[NKCellDataOBJ alloc] init];
    
    newCellOBJ.title = cellTitle;
    newCellOBJ.detailText = cellDetailText;
    newCellOBJ.accessoryView = cellAccessoryView;
    newCellOBJ.titleImage = cellTitleImage;
    
    newCellOBJ.action = cellAction;
    
    return [newCellOBJ autorelease];
    
}

+(id)cellDataOBJWithTitle:(NSString*)cellTitle detailText:(NSString*)cellDetailText accessoryView:(id)cellAccessoryView action:(SEL)cellAction{
    
    return [self cellDataOBJWithTitle:cellTitle titleImage:nil detailText:cellDetailText accessoryView:cellAccessoryView action:cellAction];
}

-(NSString*)detailText{
    
    if (self.target && self.detailTextRenderMethod && [target respondsToSelector:detailTextRenderMethod]) {
        return [target performSelector:detailTextRenderMethod];
    }
    
    return detailText;
}

-(void)addSwithWithKeyPath:(NSString*)key{
    
//    LWMDRemindSetting *remind = [[[LWAccountSettingService sharedLWAccountSettingService] accountSettingOBJ] remindSetting];
//    
//    UISwitch *swith = [[UISwitch alloc] initWithFrame:CGRectZero];
//    swith.on = [[remind valueForKeyPath:key] boolValue];
//    [swith addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
//    self.accessoryView = swith;
//    [swith release];
//    
//    self.keyPath = key;
}

-(void)valueChanged:(UISwitch*)swith{
    
//    LWAccountSettingService *service = [LWAccountSettingService sharedLWAccountSettingService];
//    LWMDRemindSetting *remind = [[service accountSettingOBJ] remindSetting];
//    
//    [remind setValue:[NSNumber numberWithBool:swith.on] forKey:self.keyPath];
//    [service updateRemindSetting];
    
}

@end
