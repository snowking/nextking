//
//  WMAddRateViewController.m
//  WEIMI
//
//  Created by King on 11/23/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMAddRateViewController.h"
#import "WMPostViewController.h"

@interface WMAddRateViewController ()

@end

@implementation WMAddRateViewController

@synthesize record;

-(void)dealloc{
    
    [record release];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)leftButtonClick:(id)sender{
    
    
    [self dismissModalViewControllerAnimated:YES];
}


-(void)setupUI{
    
    [self addleftButtonWithTitle:@"返回"];
    self.titleLabel.text = @"给他打分";
    self.dataSource = [NSMutableArray arrayWithObjects:
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"外貌"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"幽默"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"潜力"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"风度"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"专一度"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"吻技"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"XXOO"],
                       nil];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)rightButtonClick:(id)sender{
    
    
    NSString *rateString =  [self.dataSource JSONString];
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(postOK:) andFailedSelector:@selector(postFailed:)];
    [[NKRecordService sharedNKRecordService] addRecordWithTitle:nil content:nil description:rateString attTitle:nil attType:NKAttachmentTypeMan picture:nil parentID:self.record.mid type:NKRecordTypeFeed andRequestDelegate:rd];
    
    
    
}

-(void)postOK:(NKRequest*)request{
    
    
    [self leftButtonClick:nil];
    
    NKMRecord *arecord = [request.results lastObject];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NKAddFeedOKNotificationKey object:arecord];
    
    [NKMFeed resetCachedFeed];
    
}
-(void)postFailed:(NKRequest*)request{
    
    
}

@end
