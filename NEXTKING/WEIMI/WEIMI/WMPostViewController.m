//
//  WMPostViewController.m
//  WEIMI
//
//  Created by King on 11/20/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMPostViewController.h"
#import "NKImagePickerView.h"

NSString *const NKAddFeedOKNotificationKey = @"addfeedoknotificationkey";

@interface WMPostViewController ()

@end

@implementation WMPostViewController

@synthesize content;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addleftButtonWithTitle:@"取消"];
    [self addRightButtonWithTitle:@"发布"];
    
    self.headBar.backgroundColor = [UIColor lightGrayColor];
    
    NKImagePickerView *picker = [NKImagePickerView imagePickerViewForView:self.contentView];
    CGRect pickerFrame = picker.frame;
    pickerFrame.origin.y = NKMainHeight-pickerFrame.size.height;
    picker.frame = pickerFrame;
    
    self.content = [[[NKTextViewWithPlaceholder alloc] initWithFrame:CGRectMake(0, 44, 320, pickerFrame.origin.y-44)] autorelease];
    [self.contentView addSubview:content];
    content.delegate = self;
    content.font = [UIFont systemFontOfSize:14];
    content.placeholderLabel.text = @"添加内容";
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
//    [self.view addGestureRecognizer:tap];
//    [tap release];
    
}

#pragma mark TextView

- (void)textViewDidChange:(UITextView *)textView{
    [[NKMFeed cachedFeed] setContent:textView.text];
}

-(void)rightButtonClick:(id)sender{

    
    
    NKMFeed *cachedFeed = [NKMFeed cachedFeed];
    // Pic
    NSData *picData = nil;
    UIImage *image = [[[cachedFeed attachments] lastObject] picture];
    if (image) {
        picData = UIImageJPEGRepresentation(image, 0.6);
    }
    
    if ([cachedFeed.content length]<=0 && !image) {
        return;
    }
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(postOK:) andFailedSelector:@selector(postFailed:)];
    [[NKRecordService sharedNKRecordService] addRecordWithTitle:nil content:cachedFeed.content picture:picData parentID:nil type:NKRecordTypeFeed andRequestDelegate:rd];
    
}

-(void)postOK:(NKRequest*)request{
    
    
    [self leftButtonClick:nil];
    
    NKMRecord *record = [request.results lastObject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NKAddFeedOKNotificationKey object:record];
    
    [NKMFeed resetCachedFeed];
    
}
-(void)postFailed:(NKRequest*)request{
    
    
}

-(void)leftButtonClick:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)tapped:(UIGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [content resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
