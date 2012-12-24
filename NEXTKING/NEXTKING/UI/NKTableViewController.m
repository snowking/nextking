//
//  NKTableViewController.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKTableViewController.h"

@interface NKTableViewController ()

@end

@implementation NKTableViewController

@synthesize showTableView;
@synthesize dataSource;
@synthesize loadingMoreView;
@synthesize refreshHeaderView;

@synthesize shouldAutoGetMoreData;
@synthesize upsideDown;

@synthesize shouldAutoRefreshData;
@synthesize pullBackView;

-(void)dealloc{
    
    [loadingMoreView release];
    [refreshHeaderView release];
    [showTableView release];
    [dataSource release];
    [pullBackView release];
    
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setShouldAutoRefreshData:(BOOL)shouldAutoRefresh{
    
    shouldAutoRefreshData = shouldAutoRefresh;
    
    if (!shouldAutoRefreshData) {
        self.refreshHeaderView.delegate = nil;
        [self.refreshHeaderView removeFromSuperview];
        self.refreshHeaderView = nil;
    }
    else {
        EGORefreshTableHeaderView * header = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.showTableView.bounds.size.height, self.view.frame.size.width, self.showTableView.bounds.size.height) andHeaderStyle:EGORefreshTableHeaderStyleDefaultStyle];
        header.delegate = self;
        [self.showTableView addSubview:header];
        self.refreshHeaderView = header;
        [header release];
        
        //  update the last update date
        [refreshHeaderView refreshLastUpdatedDate];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.shouldAutoGetMoreData = YES;
    currentPage = 1;
    self.upsideDown = NO;
    
    self.showTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, NKContentHeight-44) style:UITableViewStylePlain] autorelease];
    showTableView.dataSource = self;
    showTableView.delegate = self;
    [self.contentView insertSubview:showTableView atIndex:0];
    showTableView.backgroundColor = [UIColor clearColor];
    showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    
    
    self.shouldAutoRefreshData = YES;
    
    if (!self.dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    
}

-(void)addUIForStyle:(NKTableViewStyle)style{
    
    
    
    UIImageView *upBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvUpBack.png"]];
    upBack.contentStretch = CGRectMake(0.5, 0.5, 0.1, 0.1);
    [self.contentView insertSubview:upBack belowSubview:showTableView];
    [upBack release];
    
    
    UIImageView *upShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvUpShadow.png"]];
    upShadow.contentStretch = CGRectMake(0.5, 0.5, 0.1, 0.1);
    [self.contentView insertSubview:upShadow aboveSubview:showTableView];
    [upShadow release];
    
    
    bottomBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvBottomBack.png"]];
    bottomBack.contentStretch = CGRectMake(0.5, 0.5, 0.1, 0.1);
    [self.contentView insertSubview:bottomBack belowSubview:showTableView];
    [bottomBack release];
    
    
    bottomShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvBottomShadow.png"]];
    bottomShadow.contentStretch = CGRectMake(0.5, 0.5, 0.1, 0.1);
    [self.contentView insertSubview:bottomShadow aboveSubview:showTableView];
    [bottomShadow release];
    
    
    
    switch (style) {
        case NKTableViewStyleFullScreen:{
            showTableView.frame = CGRectMake(0, 44, 320, NKContentHeight-44);
            [self addCardBottom];
        }
            break;
        case NKTableViewStyleFullScreenForMe:{
            showTableView.frame = CGRectMake(0, 44, 320, NKContentHeight-44);
            [self addWhiteBackground];
        }
            break;
        case NKTableViewStyleFullScreenWithOutTab:{
            showTableView.frame = CGRectMake(0, 44, 320, NKMainHeight-44);
            
            [bottomBack removeFromSuperview];
            bottomBack = nil;
            [bottomShadow removeFromSuperview];
            bottomShadow = nil;
            
            [self addCardBottom];
        }
            break;
        case NKTableViewStyleFullScreenWithAccountSetting:{
            showTableView.frame = CGRectMake(0, 44, 320, NKMainHeight-44);
            
            [bottomBack removeFromSuperview];
            bottomBack = nil;
            [bottomShadow removeFromSuperview];
            bottomShadow = nil;
            
            [self addWhiteBackground];
        }
            break;
            
        case NKTableViewStyleFullScreenWithSegment:{
            
            showTableView.frame = CGRectMake(0, 78, 320, NKContentHeight-78);
            [self addWhiteBackground];
            
        }
            break;
            
        case NKTableViewStyleSlider:{
            showTableView.frame = CGRectMake(0, 44, NKLineTableViewWidth, NKContentHeight-44);
            showTableView.showsVerticalScrollIndicator = NO;
            [self addWhiteBackground];
            [self addSliderBackground];
        }
            break;
            
        case NKTableViewStyleAlbum:{
            showTableView.frame = CGRectMake(0, 44, 320, NKMainHeight-44);
            
            [bottomBack removeFromSuperview];
            bottomBack = nil;
            [bottomShadow removeFromSuperview];
            bottomShadow = nil;
            
        }
            break;
            
        case NKTableViewStyleSliderWithSearchBar:{
            showTableView.frame = CGRectMake(0, 78, NKLineTableViewWidth, NKContentHeight-78);
            showTableView.showsVerticalScrollIndicator = NO;
            [self addWhiteBackground];
            [self addSliderBackground];
            
        }
            break;
        case NKTableViewStyleSliderLinePick:{
            showTableView.frame = CGRectMake(0, 78, NKLineTableViewWidth, NKMainHeight-78);
            showTableView.showsVerticalScrollIndicator = NO;
            [self addWhiteBackground];
            [self addSliderBackground];
            
        }
            break;
        case NKTableViewStyleLineSearch:{
            showTableView.frame = CGRectMake(0, 78, 320, NKMainHeight-78);
            [self addWhiteBackground];
            
            [bottomBack removeFromSuperview];
            bottomBack = nil;
            [bottomShadow removeFromSuperview];
            bottomShadow = nil;
            
        }
            break;
        case NKTableViewStyleRegisterLinePick:{
            showTableView.frame = CGRectMake(0, 114, 320, NKMainHeight-114);
            [self addWhiteBackground];
            
            [bottomBack removeFromSuperview];
            bottomBack = nil;
            [bottomShadow removeFromSuperview];
            bottomShadow = nil;
            
        }
            break;
            
        default:
            break;
    }
    
    
    [self.refreshHeaderView changeStyle: showTableView.frame.size.width>=320?EGORefreshTableHeaderStyleZUO:EGORefreshTableHeaderStyleZUOLeft];
    
    
    upBack.frame = CGRectMake(0, showTableView.frame.origin.y, showTableView.bounds.size.width, upBack.bounds.size.height);
    upShadow.frame = CGRectMake(0, showTableView.frame.origin.y, showTableView.bounds.size.width, upShadow.bounds.size.height);
    bottomBack.frame = CGRectMake(0, showTableView.frame.origin.y+showTableView.bounds.size.height-bottomBack.bounds.size.height, showTableView.bounds.size.width, bottomBack.bounds.size.height);
    bottomShadow.frame = CGRectMake(0, showTableView.frame.origin.y+showTableView.bounds.size.height-bottomShadow.bounds.size.height, showTableView.bounds.size.width, bottomShadow.bounds.size.height);
    
}

-(void)addSliderBackground{
    UIImageView *sliderbg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvRightCorner.png"]];
    sliderbg.contentStretch = CGRectMake(0.5, 0.5, 0.1, 0.1);
    sliderbg.frame = CGRectMake(showTableView.frame.origin.x+showTableView.bounds.size.width, showTableView.frame.origin.y+showTableView.bounds.size.height-sliderbg.bounds.size.height, 320-NKLineTableViewWidth, sliderbg.bounds.size.height);
    [self.contentView addSubview:sliderbg];
    [sliderbg release];
    
    
}

-(void)addWhiteBackground{
    
    UIImageView *tableViewBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvNormalBack.png"]];
    tableViewBg.contentStretch = CGRectMake(0.5, 0.5, 0.1, 0.1);
    [self.contentView insertSubview:tableViewBg belowSubview:showTableView];
    tableViewBg.frame = showTableView.frame;
    [tableViewBg release];
    whiteBg = tableViewBg;
    
}

-(void)addCardBottom{
    [self.refreshHeaderView changeStyle:EGORefreshTableHeaderStyleCard];
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvCard.png"]];
    background.contentStretch = CGRectMake(0.5, 0.25, 0.1, 0.05);
    background.frame = CGRectMake(0, showTableView.contentSize.height, 320, 500);
    [showTableView addSubview:background];
    [background release];
    self.pullBackView = background;
    [self setPullBackFrame];
}

-(void)setPullBackFrame{
    pullBackView.frame = CGRectMake(0, showTableView.contentSize.height-showTableView.tableFooterView.frame.size.height, 320, self.view.frame.size.height*2);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.showTableView = nil;
    self.loadingMoreView = nil;
    self.refreshHeaderView = nil;
    self.pullBackView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark ShowFooter
-(void)showFooter:(BOOL)show{
    
    self.showTableView.tableFooterView = self.loadingMoreView;
    [loadingMoreView showLoading:show];
    
}

-(void)checkPlaceholder{
    if ([self.dataSource count]) {
        UIView *holder = [self.showTableView viewWithTag:NKPlaceHolderViewTag];
        if (holder) {
            [holder removeFromSuperview];
            self.placeHolderView = nil;
        }
        [self showFooter:NO];
    }
    else {
        UIView *holder = [self.showTableView viewWithTag:NKPlaceHolderViewTag];
        if (holder) {
            [holder removeFromSuperview];
            self.placeHolderView = nil;
        }
        [self.showTableView insertSubview:self.placeHolderView atIndex:0];
        //self.showTableView.tableFooterView = nil;
    }
    
}

#pragma mark Data
-(void)getMoreData{
    
}
-(void)getMoreDataOK:(NKRequest*)request{
    [self showFooter:NO];
    gettingMoreData = NO;
    
    currentPage ++;
    
    if ([request.results count]) {
        
        [self.dataSource addObjectsFromArray:request.results];
        // 提升体验
        //[self.showTableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
        
        [self.showTableView reloadData];
        [self setPullBackFrame];
    }
}

-(void)refreshData{
    
    
    //[self performSelector:@selector(refreshDataOK:) withObject:nil afterDelay:1.0];
    
}
-(void)refreshDataOK:(NKRequest*)request{
    
    [self doneLoadingTableViewData];
    
    currentPage = 1;
    
    if ([request.results count]) {
        self.dataSource = [NSMutableArray arrayWithArray:request.results];
    }
    else {
        self.dataSource = [NSMutableArray array];
    }
    
    [self checkPlaceholder];
    [self.showTableView reloadData];
    [self setPullBackFrame];
    
    
    ProgressHide;
}

-(void)getMoreDataFailed:(NKRequest*)request{
    [self showFooter:NO];
    gettingMoreData = NO;
}
-(void)refreshDataFailed:(NKRequest*)request{
    [self doneLoadingTableViewData];
    [self checkPlaceholder];
    
    
    ProgressErrorDefault;
    
    if (request.errorCode) {
        // Do some Error
    }
    
    
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void) reloadTableViewDataSource {
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
    [self refreshData];
}

- (void) doneLoadingTableViewData {
    
    //  model should call this when its done loading
    _reloading = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.showTableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView==showTableView) {
        [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView==showTableView) {
        
        [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void) egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    
    [self reloadTableViewDataSource];
}

- (BOOL) egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    
    return _reloading;     // should return if data source model is reloading
}

- (NSDate *) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    
    return [NSDate date];     // should return date data source was last changed
}




@end




@implementation NKRequestDelegate (RefreshAndGetMore)

+(id)refreshRequestDelegateWithTarget:(id)atarget{
    
    return [NKRequestDelegate requestDelegateWithTarget:atarget finishSelector:@selector(refreshDataOK:) andFailedSelector:@selector(refreshDataFailed:)];
    
}
+(id)getMoreRequestDelegateWithTarget:(id)atarget{
    return [NKRequestDelegate requestDelegateWithTarget:atarget finishSelector:@selector(getMoreDataOK:) andFailedSelector:@selector(getMoreDataFailed:)];
}

@end
