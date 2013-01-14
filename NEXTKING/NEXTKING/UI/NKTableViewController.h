//
//  NKTableViewController.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 NK.COM. All rights reserved.
//

#import "NKViewController.h"
#import "EGORefreshTableHeaderView.h"

typedef enum {
    NKTableViewStyleFullScreen = 0,        //HomePage,
    NKTableViewStyleFullScreenForMe,       //Me
    NKTableViewStyleFullScreenWithSegment, //Notice
    NKTableViewStyleFullScreenWithOutTab,  //Welcome
    NKTableViewStyleFullScreenWithAccountSetting,  //AccountSetting
    NKTableViewStyleSlider,                //Passenger
    NKTableViewStyleSliderWithSearchBar,    //Line
    NKTableViewStyleSliderLinePick,    //Pick Line
    NKTableViewStyleLineSearch,    //LineSearch
    NKTableViewStyleRegisterLinePick,    //LineSearch
    NKTableViewStyleAlbum,
    NKTableViewStyleLineDetailFeeds,
    NKTableViewStyleLineDetailFuns
    
} NKTableViewStyle;

@interface NKTableViewController : NKViewController<UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>{
    
    UITableView    *showTableView;
    NSMutableArray *dataSource;
    
    NKLoadingMoreView           *loadingMoreView;
    EGORefreshTableHeaderView *refreshHeaderView;
    BOOL _reloading;
    BOOL gettingMoreData;
    
    
    BOOL shouldAutoGetMoreData;
    BOOL upsideDown;
    
    BOOL shouldAutoRefreshData;
    
    UIImageView *pullBackView;
    
    
    UIImageView *whiteBg;
    UIImageView *bottomBack;
    UIImageView *bottomShadow;
    
    int   currentPage;
    
    NSNumber *totalCount;
    
}

@property (nonatomic, retain) UITableView *showTableView;
@property (nonatomic, retain) NSMutableArray *dataSource;

@property (nonatomic, retain) NKLoadingMoreView *loadingMoreView;
@property (nonatomic, retain) EGORefreshTableHeaderView *refreshHeaderView;

@property (nonatomic, assign) BOOL shouldAutoGetMoreData;
@property (nonatomic, assign) BOOL upsideDown;

@property (nonatomic, assign) BOOL shouldAutoRefreshData;

@property (nonatomic, retain) UIImageView *pullBackView;
@property (nonatomic, assign) int   currentPage;

@property (nonatomic, retain) NSNumber *totalCount;


-(void)getMoreData;
-(void)getMoreDataOK:(NKRequest*)request;

-(void)refreshData;
-(void)refreshDataOK:(NKRequest*)request;

-(void)getMoreDataFailed:(NKRequest*)request;
-(void)refreshDataFailed:(NKRequest*)request;


-(void)showFooter:(BOOL)show;


-(void)doneLoadingTableViewData;

-(void)setPullBackFrame;
-(void)addUIForStyle:(NKTableViewStyle)style;
-(void)addWhiteBackground;

@end




@interface NKRequestDelegate (RefreshAndGetMore)

+(id)refreshRequestDelegateWithTarget:(id)atarget;
+(id)getMoreRequestDelegateWithTarget:(id)atarget;


@end
