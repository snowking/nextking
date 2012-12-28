//
//  NKWebViewController.h
//  ZUO
//
//  Created by King on 12/28/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKTableViewController.h"

@interface NKWebViewController : NKTableViewController{
    
    UIWebView *web;
    
}
@property (nonatomic, assign) UIWebView *web;


+(id)webViewControllerWithURL:(NSString*)url andTitle:(NSString*)title;

@end
