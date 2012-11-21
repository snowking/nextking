//
//  WMWikiViewController.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMWikiViewController.h"
#import "WMRateViewController.h"
#import "UIImage+Resize.h"


@interface WMWikiViewController ()

@end

@implementation WMWikiViewController

@synthesize man;

@synthesize name;
@synthesize tags;
@synthesize birthday;
@synthesize weiboName;
@synthesize avatar;

-(void)dealloc{
    
    [man release];
    [super dealloc];
}


+(id)wikiViewControllerForViewController:(UIViewController*)controller animated:(BOOL)animated{
    
    WMWikiViewController *post = [[self alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:post];
    [post release];
    navi.navigationBarHidden = YES;
    
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, NKMainHeight)];
    back.image = [[UIImage imageNamed:@"appBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 50, 50, 100)];
    [navi.view insertSubview:back atIndex:0];
    [back release];
    
    [controller presentModalViewController:navi animated:animated];
    [navi release];
    
    return post;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)resign:(id)sender{
    
    [name resignFirstResponder];
    [tags resignFirstResponder];
    [birthday resignFirstResponder];
    [weiboName resignFirstResponder];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addleftButtonWithTitle:@"取消"];
    [self addRightButtonWithTitle:@"下一步"];
    self.titleLabel.text = @"他的基本信息";
    
    
    UIButton *resignButton = [[UIButton alloc] initWithFrame:self.view.bounds];
    [self.contentView insertSubview:resignButton atIndex:0];
    [resignButton addTarget:self action:@selector(resign:) forControlEvents:UIControlEventTouchDown];
    [resignButton release];
    
    
    
    self.man = [NKMUser user];
    
    [avatar bindValueOfModel:man forKeyPath:@"avatar"];
    avatar.userInteractionEnabled = YES;
    avatar.target = self;
    avatar.singleTapped = @selector(preViewPhoto:);
    
    
}

-(void)leftButtonClick:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)rightButtonClick:(id)sender{
    
    if (!([name.text length] && [tags.text length] && [birthday.text length] && [weiboName.text length] && man.avatar)) {
        self.titleLabel.text = @"全都要填";
        return;
    }
    
    man.name = name.text;
    man.birthday = birthday.text;
    man.showName = weiboName.text;
    man.sign = tags.text;
    
    WMRateViewController *rate = [[WMRateViewController alloc] init];
    rate.man = self.man;
    [self.navigationController pushViewController:rate animated:YES];
    [rate release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Pick
-(IBAction)photoButtonClick:(id)sender{
    [self takePhoto:nil];
}
-(IBAction)albumButtonClick:(id)sender{
    [self album:nil];
}


-(IBAction)preViewPhoto:(UITapGestureRecognizer*)gesture{
    
 
    NKPictureViewer *viewer = [NKPictureViewer pictureViewerForView:avatar];
    [viewer showPictureForObject:man andKeyPath:@"avatar"];
    
}

//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    NSLog(@"Let's Save");
//}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo animated:(BOOL)animated{
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    UIImage * selectedImage = [image resizedImage:CGSizeMake(image.size.width / image.size.height * 640, 640) interpolationQuality:kCGInterpolationMedium];
    
    [self.man setAvatar:selectedImage];
    
    [picker dismissModalViewControllerAnimated:animated];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage * pickedImage = [info objectForKey:UIImagePickerControllerEditedImage];
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
        picker.allowsEditing = YES;
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
    picker.allowsEditing = YES;
    [controller presentModalViewController:picker animated:YES];
    [picker release];
    
}


@end
