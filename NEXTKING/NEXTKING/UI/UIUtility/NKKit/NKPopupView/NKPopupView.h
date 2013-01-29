//
//  NKPopupView.h
//  ZUO
//
//  Created by King on 12-9-22.
//  Copyright (c) 2012年 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+NKImage.h"

typedef enum {
    NKPopupViewStyleThin = 0,
    NKPopupViewStyleFatBoth,
    NKPopupViewStyleFatHeader,
    NKPopupViewStyleFatFooter,
    NKPopupViewStyleUp,
    NKPopupViewStyleLineEdit,
    NKPopupViewStyleShare,
    NKPopupViewStyleMoreAction
} NKPopupViewStyle;


@interface NKPopupCell : UITableViewCell{
    
}

+(CGFloat)cellHeight;

-(void)selectedUI:(BOOL)isSelected;

@end







@interface NKPopupView : UIView <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>{
    
    UITableView    *showTableView;
    NSMutableArray *dataSource;
    
    UIView         *contentView;
    
    UIImageView    *maskView;
    UITextField    *input;
    
    UIImageView *headback;
    UIButton *rightActionButton;
    
    UILabel *titleLabel;
    
}

@property (nonatomic, retain) UITableView    *showTableView;
@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, assign) UIView         *contentView;

@property (nonatomic, assign) UIImageView    *maskView;
@property (nonatomic, assign) UITextField    *input;

@property (nonatomic, assign) UILabel *titleLabel;

+(id)popupViewWithStyle:(NKPopupViewStyle)style;

-(void)changeStyle:(NKPopupViewStyle)style;


-(void)refreshData;
-(void)hide;


@end
