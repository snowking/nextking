//
//  WMLoginViewController.h
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKViewController.h"

@interface WMLoginViewController : NKViewController <UITextFieldDelegate>{
    
    IBOutlet UITextField *account;
    IBOutlet UITextField *password;
    
    IBOutlet UIButton *loginButton;
    
    
}

@property (nonatomic, assign) UITextField *account;
@property (nonatomic, assign) UITextField *password;
@property (nonatomic, assign) UIButton    *loginButton;


-(IBAction)forgetPassowrd:(id)sender;



@end
