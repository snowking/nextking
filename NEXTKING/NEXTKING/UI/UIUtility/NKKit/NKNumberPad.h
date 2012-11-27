//
//  NKNumberPad.h
//  MomoHelper
//
//  Created by King on 11/27/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKNumberPad : UIView{
    
    UITextField *textField;
    
    id target;
    SEL okAction;
    
}

@property (nonatomic, assign) UITextField *textField;

@property (nonatomic, assign) id  target;
@property (nonatomic, assign) SEL okAction;


+(id)numberPadForTextField:(UITextField*)field;



@end
