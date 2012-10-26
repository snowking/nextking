//
//  NKViewController.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKViewController.h"

@interface NKViewController ()

@end

@implementation NKViewController

@synthesize placeHolderView;
@synthesize headBar;
@synthesize titleLabel;

@synthesize contentView;

-(void)dealloc{
    
    
    [NKRequestDelegate removeTarget:self];
    
    [super dealloc];
}


-(IBAction)goBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)rightButtonClick:(id)sender{
    
}

-(IBAction)leftButtonClick:(id)sender{
    
}

-(UIButton*)addBackButton{
    
    UIButton *button = [self styleButton];
    
    button.frame = CGRectMake(0, 0, 54, 43);
    [button setBackgroundImage:[UIImage imageNamed:@"backbutton_normal.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"backbutton_click.png"] forState:UIControlStateHighlighted];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

-(UIButton*)addLeftCancelButton{
    return [self addleftButtonWithTitle:[NSArray arrayWithObjects:[UIImage imageNamed:@"xbutton.png"], [UIImage imageNamed:@"xbutton.png"], nil]];
    
}

-(UIButton*)addleftButtonWithTitle:(id)title{
    
    UIButton *button = [self styleButton];
    [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 60, 43);
    }
    else if ([title isKindOfClass:[NSArray class]]){
        [button setImage:[title objectAtIndex:0] forState:UIControlStateNormal];
        [button setImage:[title objectAtIndex:1] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 55, 43);
    }
    return button;
}

-(UIButton*)styleButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normal = [[UIImage imageNamed:@"topButton_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    UIImage *highlight = [[UIImage imageNamed:@"topButton_click.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    button.frame = CGRectMake(0, 0, normal.size.width, normal.size.height);
    [button setBackgroundImage:normal forState:UIControlStateNormal];
    [button setBackgroundImage:highlight forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    [button setTitleColor:[UIColor colorWithHexString:@"#4287C6"] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.headBar addSubview:button];
    [button setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    return button;
    
}

-(UIButton*)addRightButtonWithTitle:(id)title{
    
    UIButton *button = [self styleButton];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(320-60, 0, 60, 43);
    }
    else if ([title isKindOfClass:[NSArray class]]){
        [button setImage:[title objectAtIndex:0] forState:UIControlStateNormal];
        [button setImage:[title objectAtIndex:1] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(320-55, 0, 55, 43);
    }
    
    
    return button;
    
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
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, NKMainHeight);
    
    
    
    NSArray *subviews = [self.view subviews];
    
    UIView *tempView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.contentView = tempView;
    [self.view addSubview:contentView];
    [tempView release];
    
    self.headBar = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)] autorelease];
    [self.view addSubview:headBar];
    
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)] autorelease];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.center = CGPointMake(160, 22);
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    [headBar addSubview:titleLabel];
    
    
    for (UIView *view in subviews) {
        if (view.frame.origin.y<=44 && view.frame.origin.y+view.frame.size.height<=self.headBar.bounds.size.height) {
            [self.headBar addSubview:view];
        }
        else {
            [self.contentView addSubview:view];
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
