//
//  NKMultipleImageViewer.m
//  iSou
//
//  Created by King on 12-12-22.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import "NKMultipleImageViewer.h"
#import "NKKVOImageView.h"
#import "NKImageLoader.h"


@interface NKMultipleImageViewer ()


@property (nonatomic, assign) UIBarButtonItem *leftButton;
@property (nonatomic, assign) UIBarButtonItem *rightButton;

@property (nonatomic, assign) UIView *popoverOverlay;
@property (nonatomic, assign) UIView *transferView;

@property (nonatomic, assign) NSMutableArray *photoViews;
@property (nonatomic, assign) UIScrollView *scrollView;
@property (nonatomic,assign) BOOL _fromPopover;

@property (nonatomic,assign) NSInteger pageIndex;

@property (nonatomic,assign) BOOL rotating;
@property (nonatomic,assign) BOOL barsHidden;

#pragma mark - Navigation and Toolbar Styles

@property (nonatomic,assign) BOOL storedOldStyles;
@property (nonatomic,assign) BOOL oldNavBarTranslucent;
@property (nonatomic,assign) BOOL oldToolBarTranslucent;
@property (nonatomic,assign) BOOL oldToolBarHidden;

@property (nonatomic,assign) UIStatusBarStyle oldStatusBarSyle;
@property (nonatomic,assign) UIBarStyle oldNavBarStyle;
@property (nonatomic,assign) UIBarStyle oldToolBarStyle;
@property (nonatomic, assign) UIColor *oldNavBarTintColor;
@property (nonatomic, assign) UIColor *oldToolBarTintColor;

#pragma mark

@property (nonatomic,assign) BOOL autoresizedPopover;
@property (nonatomic,assign) BOOL fullScreen;

- (void)loadScrollViewWithPage:(NSInteger)page;
- (void)layoutScrollViewSubviews;
- (void)setupScrollViewContentSize;
- (void)enqueuePhotoViewAtIndex:(NSInteger)theIndex;
- (void)setBarsHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)setStatusBarHidden:(BOOL)hidden animated:(BOOL)animated;
- (NSInteger)centerPhotoIndex;
- (void)setupToolbar;
- (void)setViewState;
- (void)setupViewForPopover;

@end

@implementation NKMultipleImageViewer

@synthesize imageObjects;
@synthesize currentIndex;


@synthesize leftButton = leftButton_;
@synthesize rightButton = rightButton_;

@synthesize popoverOverlay = popoverOverlay_;
@synthesize transferView = transferView_;

@synthesize scrollView = scrollView_;
@synthesize photoViews = photoViews_;
@synthesize _fromPopover;


@synthesize pageIndex = pageIndex_;

@synthesize rotating = rotating_;
@synthesize barsHidden = barsHidden_;

@synthesize storedOldStyles = storedOldStyles_;
@synthesize oldNavBarTranslucent = oldNavBarTranslucent_;
@synthesize oldToolBarTranslucent = oldToolBarTranslucent_;
@synthesize oldToolBarHidden = oldToolBarHidden_;

@synthesize oldStatusBarSyle = oldStatusBarSyle_;
@synthesize oldNavBarStyle = oldNavBarStyle_;
@synthesize oldToolBarStyle = oldToolBarStyle_;
@synthesize oldNavBarTintColor = oldNavBarTintColor_;
@synthesize oldToolBarTintColor = oldToolBarTintColor_;

@synthesize autoresizedPopover = autoresizedPopover_;
@synthesize fullScreen = fullScreen_;

-(void)dealloc{
    
    [imageObjects release];
    
    [super dealloc];
}


+(id)multipleImageViewerWithImages:(NSArray*)images{
    
    NKMultipleImageViewer *imageViewer = [[self alloc] init];
    imageViewer.imageObjects = images;
    return [imageViewer autorelease];
}


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
    
    self.view.backgroundColor = [UIColor blackColor];
	self.wantsFullScreenLayout = YES;
	
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate=self;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    scrollView.multipleTouchEnabled=YES;
    scrollView.scrollEnabled=YES;
    scrollView.directionalLockEnabled=YES;
    scrollView.canCancelContentTouches=YES;
    scrollView.delaysContentTouches=YES;
    scrollView.clipsToBounds=YES;
    scrollView.alwaysBounceHorizontal=YES;
    scrollView.bounces=YES;
    scrollView.pagingEnabled=YES;
    scrollView.showsVerticalScrollIndicator=NO;
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.backgroundColor = self.view.backgroundColor;
    [self.contentView addSubview:scrollView];
    
    self.scrollView = scrollView;
    [scrollView release];
        
    scrollView.contentSize = CGSizeMake(320*[self.imageObjects count], scrollView.frame.size.height);
    
    CGFloat startX = 0;
    NKKVOImageView *imageView = nil;
    
    for (NKImageLoadObject *imageLoadObject in self.imageObjects) {
        imageView = [[NKKVOImageView alloc] initWithFrame:CGRectMake(startX, 0, 320, scrollView.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView bindValueOfModel:imageLoadObject forKeyPath:@"image"];
        [scrollView addSubview:imageView];
        [imageView release];
        startX+=320;
    }
    
    [scrollView scrollRectToVisible:CGRectMake(320*currentIndex, 0, 320, scrollView.frame.size.height) animated:NO];
    
    
    [self.headBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topbar_photo_gallery.png"]] autorelease] atIndex:0];
    UIButton *button = [self addRightButtonWithTitle:[NSArray arrayWithObjects:[UIImage imageNamed:@"topbar_gallery_close.png"], [UIImage imageNamed:@"topbar_gallery_close.png"], nil]];
    button.showsTouchWhenHighlighted = YES;
    button.center = CGPointMake(285, 22);
    
    
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.shadowOffset = CGSizeZero;
    self.titleLabel.center = CGPointMake(140, 22);
    self.titleLabel.text = [NSString stringWithFormat:@"Gallery %d Of %d", currentIndex+1, [self.imageObjects count]];
    
    
}

-(void)rightButtonClick:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - View Setup

- (void)setupToolbar {
	
	
}

- (NSInteger)centerPhotoIndex {
	
	CGFloat pageWidth = self.scrollView.frame.size.width;
	return floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	
}

#pragma mark - UIScrollView Delegate Methods


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	NSInteger _index = [self centerPhotoIndex];
	if (_index >= [self.imageObjects count] || _index < 0) {
		return;
	}
	
	if (self.currentIndex != _index && !self.rotating) {
        
		[self setBarsHidden:YES animated:YES];
		self.currentIndex = _index;
		[self setViewState];
		
		if (![scrollView isTracking]) {
            
			[self layoutScrollViewSubviews];
		} 
		
	}
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	
	NSInteger _index = [self centerPhotoIndex];
	if (_index >= [self.imageObjects count] || _index < 0) {
		return;
	}
	
	[self moveToPhotoAtIndex:_index animated:YES];
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
	[self layoutScrollViewSubviews];
}

-(void)layoutScrollViewSubviews{
    self.titleLabel.text = [NSString stringWithFormat:@"Gallery %d Of %d", currentIndex+1, [self.imageObjects count]];
}

-(void)setBarsHidden:(BOOL)barsHidden animated:(BOOL)animated{
    
}
-(void)moveToPhotoAtIndex:(NSInteger)index animated:(BOOL)animated{
    
}
-(void)setViewState{
    
}

@end
