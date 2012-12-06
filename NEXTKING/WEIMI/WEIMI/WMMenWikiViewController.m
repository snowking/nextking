//
//  WMMenWikiViewController.m
//  WEIMI
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMMenWikiViewController.h"
#import "WMWikiViewController.h"
#import "WMMenCell.h"
#import "WMManDetailViewController.h"


@interface WMMenWikiViewController ()

@end

@implementation WMMenWikiViewController

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"manOK" object:nil];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(manOK:) name:@"manOK" object:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = @"八卦百科";
    
    [self addRightButtonWithTitle:@"添加男人"];
    
    UIImageView *book = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bluebook.png"]];
    [self.contentView insertSubview:book atIndex:0];
    CGRect bookFrame = book.frame;
    bookFrame.origin.y = 44;
    book.frame = bookFrame;
    [book release];
    
    [self refreshData];
    
}

-(void)rightButtonClick:(id)sender{
    
    [WMWikiViewController wikiViewControllerForViewController:NKNC animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Data

-(void)manOK:(NSNotification*)anoti{
    
    NKMRecord *record = [anoti object];
    [self.dataSource insertObject:record atIndex:0];
    [showTableView reloadData];
    
}

-(void)refreshData{
    
    NKRequestDelegate *rd = [NKRequestDelegate refreshRequestDelegateWithTarget:self];
    
    [[NKRecordService sharedNKRecordService] listAllWikiWithOffset:0 size:15 andRequestDelegate:rd];
    
}

-(void)setPullBackFrame{
   
}

#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [WMMenCell cellHeightForObject:[self.dataSource objectAtIndex:indexPath.row]];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"WMFeedCellIdentifier";
    
    WMMenCell *cell = (WMMenCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[WMMenCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NKMRecord *message = [self.dataSource objectAtIndex:indexPath.row];
    [cell showForObject:message];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NKMRecord *recod = [self.dataSource objectAtIndex:indexPath.row];
    
    [WMManDetailViewController manDetailWithRecord:recod];
    
}





@end
