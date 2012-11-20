//
//  NKImagePickerView.h
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NKPictureViewer.h"
#import "NKSDK.h"


@interface NKImagePickerView : UIView <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (nonatomic, assign) UIView            *buttonContainer;
@property (nonatomic, assign) UIView            *preContainer;
@property (nonatomic, assign) NKKVOImageView    *imagePreview;

@property (nonatomic, assign) UIButton          *photoButton;
@property (nonatomic, assign) UIButton          *albumButton;


+(id)imagePickerViewForView:(UIView*)view;

-(IBAction)takePhoto:(id)sender;
-(IBAction)album:(id)sender;

-(IBAction)cleanPhoto:(id)sender;
-(IBAction)preViewPhoto:(id)sender;

@end
