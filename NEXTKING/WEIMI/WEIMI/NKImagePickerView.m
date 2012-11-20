//
//  NKImagePickerView.m
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKImagePickerView.h"
#import "UIImage+Resize.h"

@implementation NKImagePickerView

@synthesize buttonContainer;
@synthesize preContainer;
@synthesize imagePreview;
@synthesize photoButton;
@synthesize albumButton;


+(id)imagePickerViewForView:(UIView*)view{
    
    NKImagePickerView *picker = [[self alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    
    [view addSubview:picker];
    return [picker autorelease];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo animated:(BOOL)animated{
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    UIImage * selectedImage = [image resizedImage:CGSizeMake(image.size.width / image.size.height * 960, 960) interpolationQuality:kCGInterpolationMedium];
    
    [[[[NKMFeed cachedFeed] attachments] lastObject] setPicture:selectedImage];
    
    [picker dismissModalViewControllerAnimated:animated];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self imagePickerController:picker didFinishPickingImage:pickedImage editingInfo:info animated:YES];
}



-(IBAction)takePhoto:(id)sender{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera]) {
        
        UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        while ([controller isKindOfClass:[UINavigationController class]]) {
            controller = [(UINavigationController*)controller visibleViewController];
        }
        // show the image picker
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = NO;
        [controller presentModalViewController:picker animated:YES];
        [picker release];
        
    } else {
        [self performSelector:@selector(album:) withObject:nil];
    }
    
}
-(IBAction)album:(id)sender{
    UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while ([controller isKindOfClass:[UINavigationController class]]) {
        controller = [(UINavigationController*)controller visibleViewController];
    }
    // show the image picker
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.sourceType = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]?UIImagePickerControllerSourceTypePhotoLibrary:UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [controller presentModalViewController:picker animated:YES];
    [picker release];
    
}

-(IBAction)cleanPhoto:(id)sender{
    
    [[[[NKMFeed cachedFeed] attachments] lastObject] setPicture:nil];
}

-(IBAction)preViewPhoto:(id)sender{
    
    NKPictureViewer *viewer = [NKPictureViewer pictureViewerForView:imagePreview];
    [viewer showPictureForObject:[[[NKMFeed cachedFeed] attachments] lastObject] andKeyPath:@"picture"];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor lightGrayColor];
        
        self.preContainer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 200)] autorelease];
        [self addSubview:preContainer];
        
        self.buttonContainer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 200)] autorelease];
        [self addSubview:buttonContainer];
        
        self.imagePreview = [[[NKKVOImageView alloc] initWithFrame:CGRectMake(60, 20, 200, 150)] autorelease];
        [preContainer addSubview:imagePreview];
        imagePreview.contentMode = UIViewContentModeScaleAspectFill;
        imagePreview.clipsToBounds = YES;
        imagePreview.target = self;
        imagePreview.renderMethod = @selector(renderImage:);
        [imagePreview bindValueOfModel:[[[NKMFeed cachedFeed] attachments] lastObject] forKeyPath:@"picture"];
        
        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 40, 40)];
        [preContainer addSubview:clearButton];
        [clearButton release];
        [clearButton addTarget:self action:@selector(cleanPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [clearButton setTitle:@"清除" forState:UIControlStateNormal];
        
        self.photoButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 20, 320, 50)] autorelease];
        [photoButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [photoButton setTitle:@"拍照" forState:UIControlStateNormal];
        [buttonContainer addSubview:photoButton];
        photoButton.backgroundColor = [UIColor grayColor];
        
        self.albumButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 90, 320, 50)] autorelease];
        [albumButton addTarget:self action:@selector(album:) forControlEvents:UIControlEventTouchUpInside];
        [albumButton setTitle:@"相册" forState:UIControlStateNormal];
        [buttonContainer addSubview:albumButton];
        albumButton.backgroundColor = [UIColor grayColor];
        
        
    }
    return self;
}

-(UIImage*)renderImage:(UIImage*)image{
    
    if (image) {
        preContainer.alpha = 1.0;
        CGRect frame = buttonContainer.frame;
        frame.origin.y = 160;
        buttonContainer.frame = frame;
    }
    
    else {
        [UIView animateWithDuration:0.2 animations:^{
            preContainer.alpha = 0.0;
        } completion:^(BOOL finished) {
            imagePreview.image = nil;
            CGRect frame = buttonContainer.frame;
            frame.origin.y = 0;
            [UIView animateWithDuration:0.3 animations:^{
                buttonContainer.frame = frame;
            }];
            
        }];
    }
    
    return image;
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
