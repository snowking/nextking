//
//  WMFeedDetailViewController.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMFeedDetailViewController.h"
#import "ZUOCommentCell.h"

@interface WMFeedDetailViewController ()

@end

@implementation WMFeedDetailViewController
@synthesize record;
@synthesize commentView;

-(void)dealloc{
    
    [record release];
    [super dealloc];
}


+(id)feedDetailWithRecord:(NKMRecord*)theRecord{
    
    WMFeedDetailViewController *feedDetail = [[self alloc] init];
    feedDetail.record = theRecord;
    [NKNC pushViewController:feedDetail animated:YES];
    return [feedDetail autorelease];
    
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
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    [pan release];
    
    
    // Do any additional setup after loading the view from its nib.
    [self addBackButton];
    
    self.titleLabel.text = @"详细内容";
    
    UIView *tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    
    
    NKKVOImageView *avatar = [[NKKVOImageView alloc] initWithFrame:CGRectMake(6, 6, 48, 48)];
    [tableViewHeader addSubview:avatar];
    [avatar release];
    [avatar bindValueOfModel:record.sender forKeyPath:@"avatar"];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 6, 254, 20)];
    [tableViewHeader addSubview:nameLabel];
    [nameLabel release];
    nameLabel.text = record.sender.name;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 254, 24)];
    [tableViewHeader addSubview:contentLabel];
    [contentLabel release];
    contentLabel.text = record.content;
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = [UIFont systemFontOfSize:10];
    
    
    if ([record.attachments lastObject]) {
        
        NKKVOImageView *picture = [[NKKVOImageView alloc] initWithFrame:CGRectMake(6, 60, 308, 231)];
        [tableViewHeader addSubview:picture];
        [picture release];
        picture.contentMode = UIViewContentModeScaleAspectFill;
        picture.clipsToBounds = YES;
        picture.target = self;
        picture.singleTapped = @selector(pictureTapped:);
        [picture bindValueOfModel:[record.attachments lastObject] forKeyPath:@"picture"];
        
        tableViewHeader.frame = CGRectMake(0, 0, 320, 291);
        
    }
    
    self.showTableView.tableHeaderView = tableViewHeader;
    [tableViewHeader release];

    
    self.commentView = [NKInputView inputViewWithTableView:self.showTableView dataSource:self.dataSource otherView:nil];
    [self.contentView addSubview:commentView];
    commentView.target = self;
    commentView.action = @selector(addComment:);
    
    
    
    
    [self refreshData];
    
}

-(void)pictureTapped:(UITapGestureRecognizer*)gesture{
    
    NKPictureViewer *viewer = [NKPictureViewer pictureViewerForView:[gesture view]];
    [viewer showPictureForObject:[[record attachments] lastObject] andKeyPath:@"picture"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Data

-(void)refreshData{
    
    NKRequestDelegate *rd = [NKRequestDelegate refreshRequestDelegateWithTarget:self];
    
    [[NKRecordService sharedNKRecordService] listRecordWithPID:record.mid offset:0 size:15 andRequestDelegate:rd];
    
}

-(void)setPullBackFrame{
    
    commentView.dataSource = self.dataSource;
}

#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [ZUOCommentCell cellHeightForObject:[self.dataSource objectAtIndex:indexPath.row]];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * CellIdentifier = @"WMFeedCellIdentifier";
    
    ZUOCommentCell *cell = (ZUOCommentCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[ZUOCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NKMRecord *message = [self.dataSource objectAtIndex:indexPath.row];
    [cell showForObject:message];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


#pragma mark Add Comment

-(void)addComment:(NSString*)content{
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(addCommentOK:) andFailedSelector:@selector(addCommentFailed:)];
    
    [[NKRecordService sharedNKRecordService] addRecordWithTitle:nil content:content picture:nil parentID:self.record.mid type:nil andRequestDelegate:rd];
    
}


-(void)addCommentOK:(NKRequest*)request{
    
    [self.dataSource addObject:[request.results lastObject]];
    
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:[self.dataSource count]-1 inSection:0];
    
    [showTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:lastIndex] withRowAnimation:UITableViewRowAnimationFade];
    [showTableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self setPullBackFrame];
    [commentView sendOK];
}

-(void)addCommentFailed:(NKRequest*)request{
    
    
}

#pragma mark Gesture
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if ([[otherGestureRecognizer view] isKindOfClass:[UITableView class]]) {
        [commentView hide];
        return YES;
    }
    
    return NO;
}

@end
