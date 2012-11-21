//
//  WMWikiViewController.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMWikiViewController.h"
#import "WMRateViewController.h"



@interface WMWikiViewController ()

@end

@implementation WMWikiViewController

@synthesize man;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addleftButtonWithTitle:@"取消"];
    [self addRightButtonWithTitle:@"下一步"];
    self.titleLabel.text = @"他的基本信息";
    
}

-(void)leftButtonClick:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)rightButtonClick:(id)sender{
    
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

@end
