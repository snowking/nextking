//
//  WMMiViewController.m
//  WEIMI
//
//  Created by King on 11/19/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMMiViewController.h"
#import "WMFeedCell.h"
#import "WMPostViewController.h"

@interface WMMiViewController ()

@end

@implementation WMMiViewController
@synthesize user;
@synthesize delegate;

-(void)dealloc{
    
    [user release];
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
    
    NSLog(@"%@", self.user.relation);
    
    
    if ([user.relation isEqualToString:NKRelationFriend] || user == [NKMUser me]) {
        // show content
        
        [self frinedShow];
        
        
    }
    else if ([user.relation isEqualToString:NKRelationFollow]){
        // show Follow
        [self showFollowView];
        
    }
    else if ([user.relation isEqualToString:NKRelationFollower]){
        // show follower Accept or something
        
        [self showFollowerView];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)frinedShow{
    
    showTableView.tableFooterView = nil;
    [self refreshData];
    
    
    if (self.user == [NKMUser me]) {
        showTableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
        
        UIButton *postButton = [[UIButton alloc] initWithFrame:showTableView.tableHeaderView.bounds];
        [showTableView.tableHeaderView addSubview:postButton];
        [postButton release];
        [postButton setTitle:@"发布" forState:UIControlStateNormal];
        [postButton addTarget:self action:@selector(addNewFeed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

-(void)addNewFeed:(id)sender{
    
    WMPostViewController *post = [[WMPostViewController alloc] init];
    [NKNC presentModalViewController:post animated:YES];
    [post release];
    
}

#pragma mark Relation

-(void)showFollowView{
    
    UIView *footer = [[UIView alloc] initWithFrame:showTableView.bounds];
    showTableView.tableFooterView = footer;
    [footer release];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 60)];
    [footer addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"%@ 邀请已经发送", user.name];;
    [label release];
    
    
    UIButton *unfollowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 320, 60)];
    [footer addSubview:unfollowButton];
    [unfollowButton release];
    [unfollowButton setTitle:@"取消这个邀请" forState:UIControlStateNormal];
    [unfollowButton addTarget:self action:@selector(unfollow:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)unfollowOK:(NKRequest*)request{

    if ([delegate respondsToSelector:@selector(controller:didUnfollowUser:)]) {
        [delegate controller:self didUnfollowUser:[request.results lastObject]];
    }
    
}
-(void)unfollowFailed:(NKRequest*)request{
    
}

-(void)unfollow:(id)sender{
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(unfollowOK:) andFailedSelector:@selector(unfollowFailed:)];
    [[NKUserService sharedNKUserService] unFollowUserWithUID:self.user.mid andRequestDelegate:rd];
    
}

-(void)followOK:(NKRequest*)request{
    
    [self frinedShow];
    
    
}
-(void)followFailed:(NKRequest*)request{
    
}

-(void)follow:(id)sender{
    
    NKRequestDelegate *rd = [NKRequestDelegate requestDelegateWithTarget:self finishSelector:@selector(followOK:) andFailedSelector:@selector(followFailed:)];
    [[NKUserService sharedNKUserService] followUserWithUID:self.user.mid andRequestDelegate:rd];
}

-(void)showFollowerView{
    
    UIView *footer = [[UIView alloc] initWithFrame:showTableView.bounds];
    showTableView.tableFooterView = footer;
    [footer release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 320, 60)];
    [footer addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 0;
    label.text =  [NSString stringWithFormat:@"%@ 把你加为了最好的5个闺蜜之一", user.name];
    [label release];
    
    
    UIButton *followButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 160, 60)];
    [footer addSubview:followButton];
    [followButton release];
    [followButton setTitle:@"接受" forState:UIControlStateNormal];
    [followButton addTarget:self action:@selector(follow:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *unfollowButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 100, 160, 60)];
    [footer addSubview:unfollowButton];
    [unfollowButton release];
    [unfollowButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [unfollowButton addTarget:self action:@selector(unfollow:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark Data

-(void)refreshData{
    
    NKRequestDelegate *rd = [NKRequestDelegate refreshRequestDelegateWithTarget:self];
    
    [[NKRecordService sharedNKRecordService] listRecordWithUID:self.user.mid offset:0 size:15 andRequestDelegate:rd];

}

#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [WMFeedCell cellHeightForObject:nil];
    
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
    
    NKMRecord *record = [self.dataSource objectAtIndex:indexPath.row];
    [cell showForObject:record];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  
}


@end
