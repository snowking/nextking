//
//  NKWebViewController.m
//  ZUO
//
//  Created by King on 12/28/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKWebViewController.h"

@interface NKWebViewController ()

@end

@implementation NKWebViewController

@synthesize web;

-(void)dealloc{
    
    [super dealloc];
}

+(id)webViewControllerWithURL:(NSString*)url andTitle:(NSString*)title{
    
    NKWebViewController *webViewController = [[self alloc] init];
    [NKNC pushViewController:webViewController animated:YES];
    [webViewController.web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    webViewController.titleLabel.text = title;
    return [webViewController autorelease];
    
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
    
    [self addBackButton];
    
    self.web = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, NKMainHeight-44)] autorelease];
    [self.contentView addSubview:web];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
