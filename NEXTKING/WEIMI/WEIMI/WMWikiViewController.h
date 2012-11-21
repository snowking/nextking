//
//  WMWikiViewController.h
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKViewController.h"

@interface WMWikiViewController : NKViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    NKMUser *man;
}

@property (nonatomic, retain) NKMUser *man;


@property (nonatomic, assign) IBOutlet UITextField *name;
@property (nonatomic, assign) IBOutlet UITextField *tags;
@property (nonatomic, assign) IBOutlet UITextField *birthday;
@property (nonatomic, assign) IBOutlet UITextField *weiboName;
@property (nonatomic, assign) IBOutlet NKKVOImageView *avatar;


+(id)wikiViewControllerForViewController:(UIViewController*)controller animated:(BOOL)animated;


-(IBAction)photoButtonClick:(id)sender;
-(IBAction)albumButtonClick:(id)sender;



@end
