//
//  WMRateViewController.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMRateViewController.h"
#import "WMRateCell.h"

@interface WMRateViewController ()

@end

@implementation WMRateViewController

@synthesize man;

-(void)dealloc{
    
    [man release];
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
    
    
    
    [self addRightButtonWithTitle:@"完成"];
    [self setShouldAutoRefreshData:NO];
    self.showTableView.frame = CGRectMake(0, 44, 320, NKMainHeight-44);
    
    [self setupUI];
        
}

-(void)setupUI{
    
    [self addBackButton];
    self.titleLabel.text = @"给他初始打分";
    self.dataSource = [NSMutableArray arrayWithObjects:
                       
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"外貌"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"幽默"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"潜力"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"风度"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"专一度"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"吻技"],
                       [NSMutableDictionary dictionaryWithObject:@"?" forKey:@"XXOO"],
                       nil];

    
}

-(void)rightButtonClick:(id)sender{
    
    
    NSString *rateString =  [self.dataSource JSONString];
    
    NSLog(@"%@", rateString);
    
    NSDictionary *manDic = [NSDictionary dictionaryWithObjectsAndKeys:man.name, @"name", man.showName, @"showName", man.birthday, @"birthday", man.sign, @"tags", nil];
    NSString *manString = [manDic JSONString];
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(addWikiOK:) andFailedSelector:@selector(addWikiFailed:)];

    [[NKRecordService sharedNKRecordService] addRecordWithTitle:nil content:nil description:rateString attTitle:manString attType:NKAttachmentTypeMan picture:UIImageJPEGRepresentation(self.man.avatar, 0.6) parentID:nil type:NKRecordTypeGroup andRequestDelegate:rd];
    
    
}


-(void)addWikiOK:(NKRequest*)request{
    
    
    [self dismissModalViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"manOK" object:[request.results lastObject]];
    
    
}

-(void)addWikiFailed:(NKRequest*)request{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [WMRateCell cellHeightForObject:[self.dataSource objectAtIndex:indexPath.row]];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"WMFeedCellIdentifier";
    
    WMRateCell *cell = (WMRateCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[WMRateCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }

    [cell showForObject:[self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
