//
//  NKViewController.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKSDK.h"
#import "NKDataStore.h"
#import "NKUI.h"

#define NKPlaceHolderViewTag 60008

@interface NKViewController : UIViewController{
    
    UIView  *placeHolderView;
    UIView  *headBar;
    UILabel *titleLabel;
    
    UIView  *contentView;
}

@property (nonatomic, assign) UIView  *placeHolderView;
@property (nonatomic, assign) UIView  *headBar;
@property (nonatomic, assign) UILabel *titleLabel;

@property (nonatomic, assign) UIView  *contentView;


-(IBAction)goBack:(id)sender;
-(IBAction)rightButtonClick:(id)sender;
-(IBAction)leftButtonClick:(id)sender;

-(UIButton*)addRightButtonWithTitle:(id)title;
-(UIButton*)addleftButtonWithTitle:(id)title;
-(UIButton*)addBackButton;
-(UIButton*)addLeftCancelButton;

@end
