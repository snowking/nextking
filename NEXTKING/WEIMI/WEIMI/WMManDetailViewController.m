//
//  WMManDetailViewController.m
//  WEIMI
//
//  Created by King on 11/22/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMManDetailViewController.h"
#import "WMFeedCell.h"
#import "WMPostViewController.h"
#import "WMFeedDetailViewController.h"
#import "WMAddRateViewController.h"

@interface WMManDetailViewController ()

@end

@implementation WMManDetailViewController

@synthesize record;

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NKAddFeedOKNotificationKey object:nil];
    
    [record release];
    [super dealloc];
}

+(id)manDetailWithRecord:(NKMRecord*)arecord{
    
    WMManDetailViewController *manDetail = [[self alloc] init];
    manDetail.record = arecord;
    [NKNC pushViewController:manDetail animated:YES];
    [manDetail release];
    
    return manDetail;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addFeedOK:) name:NKAddFeedOKNotificationKey object:nil];
    }
    return self;
}

-(void)addFeedOK:(NSNotification*)noti{
    
    [self.dataSource addObject:[noti object]];
    [showTableView reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addBackButton];
    [self addRightButtonWithTitle:@"发八卦"];
    
    self.titleLabel.text = record.man.showName;
    
    
    UIButton *rateButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 0, 60, 44)];
    [self.headBar addSubview:rateButton];
    [rateButton addTarget:self action:@selector(addRate:) forControlEvents:UIControlEventTouchUpInside];
    [rateButton setTitle:@"打分" forState:UIControlStateNormal];
    [rateButton release];
    
    UIView *tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    NKKVOImageView *avatar = [[NKKVOImageView alloc] initWithFrame:CGRectMake(6, 6, 48, 48)];
    [tableViewHeader addSubview:avatar];
    [avatar release];
    [avatar bindValueOfModel:[record.attachments lastObject] forKeyPath:@"picture"];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 6, 254, 20)];
    [tableViewHeader addSubview:nameLabel];
    [nameLabel release];
    nameLabel.text = record.man.sign;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 254, 24)];
    [tableViewHeader addSubview:contentLabel];
    [contentLabel release];
    contentLabel.text = record.man.birthday;
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = [UIFont systemFontOfSize:10];
    
    self.showTableView.tableHeaderView = tableViewHeader;
    [tableViewHeader release];
    showTableView.frame = CGRectMake(0, 44, 320, NKMainHeight-44);
    
    [self refreshData];
}

-(void)rightButtonClick:(id)sender{
    
    WMPostViewController *post = [[WMPostViewController alloc] init];
    post.parent = self.record;
    [NKNC presentModalViewController:post animated:YES];
    post.titleLabel.text = [self.record.man.showName stringByAppendingFormat:@"%@", @"的八卦"];
    [post release];
    
}

-(void)addRate:(id)sender{
    
    WMAddRateViewController *addRate = [[WMAddRateViewController alloc] init];
    addRate.record = self.record;
    [NKNC presentModalViewController:addRate animated:YES];
    [addRate release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)refreshData{
    
    NKRequestDelegate *rd = [NKRequestDelegate refreshRequestDelegateWithTarget:self];
    
    [[NKRecordService sharedNKRecordService] listRecordWithPID:record.mid offset:0 size:15 andRequestDelegate:rd];
    
}

-(void)setPullBackFrame{
    
}

#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [WMFeedCell cellHeightForObject:[self.dataSource objectAtIndex:indexPath.row]];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"WMFeedCellIdentifier";
    
    WMFeedCell *cell = (WMFeedCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[WMFeedCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NKMRecord *message = [self.dataSource objectAtIndex:indexPath.row];
    [cell showForObject:message];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NKMRecord *recod = [self.dataSource objectAtIndex:indexPath.row];
    
    [WMFeedDetailViewController feedDetailWithRecord:recod];
    
}

@end
