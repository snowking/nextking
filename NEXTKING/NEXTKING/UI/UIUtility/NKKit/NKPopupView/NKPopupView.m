//
//  NKPopupView.m
//  ZUO
//
//  Created by King on 12-9-22.
//  Copyright (c) 2012年 ZUO.COM. All rights reserved.
//

#import "NKPopupView.h"

#define FontSize 14

@implementation NKPopupCell

-(void)dealloc{
    
    [super dealloc];
}

+(CGFloat)cellHeight{
    
    return 51;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.backgroundView = [[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pucellback_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 20)]] autorelease];
        
        self.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"pucellback_highlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 20, 10, 20)]] autorelease];
        
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont boldSystemFontOfSize:FontSize];
        
    }
    return self;
}

-(void)selectedUI:(BOOL)isSelected{
    self.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:isSelected?@"pumultiselect_se.png":@"pumultiselect_un.png"] highlightedImage:[UIImage imageNamed:isSelected?@"pumultiselect_se_click.png":@"pumultiselect_un_click.png"]] autorelease];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



@implementation NKPopupView

@synthesize showTableView;
@synthesize dataSource;

@synthesize contentView;

@synthesize maskView;
@synthesize input;

-(void)dealloc{
    
    [showTableView release];
    [dataSource release];
    
    [super dealloc];
}

+(id)popupViewWithStyle:(NKPopupViewStyle)style{
    
    
    UIWindow *topWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    NKPopupView *newView = [[self alloc] initWithFrame:topWindow.bounds];
    [newView changeStyle:style];
    [topWindow addSubview:newView];
    
    return [newView autorelease];
    
}

-(void)changeStyle:(NKPopupViewStyle)style{
    
    switch (style) {
        case NKPopupViewStyleThin:{
            maskView.image = [[UIImage imageNamed:@"pumaskthin.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
            maskView.frame = CGRectMake(0, 0, 266, 354);
            maskView.center = self.center;
            showTableView.frame = CGRectMake(0, 0, 236, 324);
            showTableView.center = CGPointMake(self.center.x, self.center.y-1);
            
        }
            break;
        case NKPopupViewStyleUp:{
            maskView.image = [[UIImage imageNamed:@"pumaskthin.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
            maskView.frame = CGRectMake(0, 0, 266, 153+30);
            maskView.center = CGPointMake(self.center.x, 155);
            showTableView.frame = CGRectMake(0, 0, 236, 153);
            showTableView.center = CGPointMake(self.center.x, maskView.center.y-1);
            
        }
            break;
        case NKPopupViewStyleFatBoth:{
            
            maskView.image = [[UIImage imageNamed:@"pumaskfatboth.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 50, 100, 50)];
            maskView.frame = CGRectMake(0, 0, 266, 354);
            maskView.center = self.center;
            showTableView.frame = CGRectMake(0, 0, 236, 235);
            showTableView.center = CGPointMake(self.center.x, self.center.y-3);
            
            [self addHeaderWithPlaceHolder:@"输入特征描述" andTitle:@"添加"];
            
            
            UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(66, maskView.center.y+101, 238, 40)];
            [doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [doneButton setBackgroundImage:[UIImage imageNamed:@"pudonebutton_normal.png"] forState:UIControlStateNormal];
            [doneButton setBackgroundImage:[UIImage imageNamed:@"pudonebutton_click.png"] forState:UIControlStateHighlighted];
            [doneButton setTitle:@"完成" forState:UIControlStateNormal];
            [contentView addSubview:doneButton];
            doneButton.center = CGPointMake(maskView.center.x, maskView.frame.origin.y+maskView.frame.size.height - 38);
            doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:FontSize];
            [doneButton release];
            
            
            
        }
            break;
        case NKPopupViewStyleFatFooter:{
            
            
        }
            break;
        case NKPopupViewStyleFatHeader:{
            
            maskView.image = [[UIImage imageNamed:@"pumaskfatheader.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 50, 50, 50)];
            maskView.frame = CGRectMake(0, 0, 266, 354);
            maskView.center = self.center;
            showTableView.frame = CGRectMake(0, 0, 236, 279);
            showTableView.center = CGPointMake(self.center.x, self.center.y+20);
            
            [self addHeaderWithPlaceHolder:@"输入相册名或搜索" andTitle:@"创建"];
            
            
        }
            break;
        default:
            break;
    }
    
    
    
}

-(void)addHeaderWithPlaceHolder:(NSString*)placeHolder andTitle:(NSString*)title{
    UIImageView *headback = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"puinputback.png"]];
    [maskView addSubview:headback];
    [headback release];
    headback.center = CGPointMake(maskView.bounds.size.width/2, 34);
    
    self.input = [[[UITextField alloc] initWithFrame:CGRectMake(maskView.frame.origin.x +25, maskView.frame.origin.y + headback.center.y-10, 150, 20)] autorelease];
    [self.contentView addSubview:input];
    input.placeholder = placeHolder;
    input.font = [UIFont systemFontOfSize:FontSize];
    input.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    input.clipsToBounds = YES;
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(maskView.frame.origin.x +186, maskView.frame.origin.y + headback.center.y-15, 60, 30)];
    [self.contentView addSubview:button];
    [button release];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"puinputbutton_normal.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"puinputbutton_click.png"] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:FontSize];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    

}

-(void)headButtonClick:(id)sender{
    
    
    
}

-(void)doneButtonClick:(id)sender{
    
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
        UIImageView *background = [[UIImageView alloc] initWithFrame:self.bounds];
        background.backgroundColor = [UIColor blackColor];
        background.alpha = 0.5;
        [self addSubview:background];
        [background release];
        
        self.contentView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
        [self addSubview:contentView];
        
        UIButton *tap = [[UIButton alloc] initWithFrame:self.bounds];
        [tap addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchDown];
        [contentView addSubview:tap];
        [tap release];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMoved:)];
        [contentView addGestureRecognizer:pan];
        pan.delegate = self;
        [pan release];
        
        self.showTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)] autorelease];
        [self.contentView addSubview:showTableView];
        [showTableView setDataSource:self];
        [showTableView setDelegate:self];
        showTableView.center = self.center;
        showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        showTableView.clipsToBounds = YES;
        showTableView.backgroundColor = [UIColor colorWithRed:248.0/256.0 green:249.0/256.0 blue:250.0/256.0 alpha:1];
        
        self.maskView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
        [self.contentView addSubview:maskView];
        
        
        UIImageView *headLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 236, 10)];
        headLine.contentMode = UIViewContentModeBottom;
        headLine.clipsToBounds = YES;
        headLine.image = [UIImage imageNamed:@"pucellback_normal.png"];
        [showTableView addSubview:headLine];
        [headLine release];
        
        
        [self refreshData];
        
    }
    return self;
}

-(void)hide{
    
    [input resignFirstResponder];
    
   [UIView animateWithDuration:0.3 animations:^{
       self.alpha = 0;
   } completion:^(BOOL finished) {
       [self removeFromSuperview];
   }];
}

-(void)tapped:(id)recgo{
    
    
    if ([input isFirstResponder]) {
        [input resignFirstResponder];
    }
    else{
        [self hide];
    }
    
    
}
-(void)panMoved:(id)sender{
    
    if ([input isFirstResponder]) {
        [input resignFirstResponder];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    
    if ([input isFirstResponder]) {
        [input resignFirstResponder];
    }
    return YES;
}


#pragma mark TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [NKPopupCell cellHeight];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier = @"NKPopupViewCell";
    
    NKPopupCell *cell = (NKPopupCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NKPopupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [self configCell:cell atIndexPath:indexPath];
    
    return cell;

}

-(void)configCell:(NKPopupCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark Data
-(void)refreshData{
    
    self.dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
