//
//  WMWikiViewController.h
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKViewController.h"

@interface WMWikiViewController : NKViewController{
    
    NKMUser *man;
}

@property (nonatomic, retain) NKMUser *man;


+(id)wikiViewControllerForViewController:(UIViewController*)controller animated:(BOOL)animated;

@end
