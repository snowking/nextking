//
//  WMMiViewController.h
//  WEIMI
//
//  Created by King on 11/19/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKTableViewController.h"

@protocol WMMiViewControllerDelegate;

@interface WMMiViewController : NKTableViewController{
    
    NKMUser *user;
}

@property (nonatomic, retain) NKMUser *user;

@property (nonatomic, assign) id<WMMiViewControllerDelegate> delegate;

@end


@protocol WMMiViewControllerDelegate <NSObject>

@optional

-(void)controller:(WMMiViewController*)controller didUnfollowUser:(NKMUser*)user;

@end