//
//  NKNavigationController.m
//  ZUO
//
//  Created by King on 12/5/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "NKNavigationController.h"
#import "NKUI.h"

@interface NKNavigationController ()

@end

@implementation NKNavigationController

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
    
    self.view.backgroundColor = [UIColor clearColor];
    //navi.supportedInterfaceOrientations =
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, NKMainHeight)];
    back.image = [[UIImage imageNamed:@"appBackground.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 50, 100, 50)];
    [self.view insertSubview:back atIndex:0];
    [back release];
    [self setNavigationBarHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
