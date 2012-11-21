//
//  WMRateCell.m
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "WMRateCell.h"

@implementation WMRateCell

@synthesize rateLabel;

-(void)showForObject:(id)object{
    
    self.showedObject = object;
    
    NSDictionary *dic = object;
    
    self.textLabel.text = [[dic allKeys] lastObject];
    self.rateLabel.text = [NSString stringWithFormat:@"%@", [[dic allValues] lastObject]];
    
}

-(void)plus:(id)sender{
    
    
    int value = [[[showedObject allValues] lastObject] isKindOfClass:[NSString class]]?5:[[[showedObject allValues] lastObject] intValue];
    
    [self.showedObject setValue:[NSNumber numberWithInt:MIN(10, value+1)] forKey:[[showedObject allKeys] lastObject]];
    
    self.rateLabel.text = [NSString stringWithFormat:@"%@", [[showedObject allValues] lastObject]];
}

-(void)minus:(id)sender{
    
    int value = [[[showedObject allValues] lastObject] isKindOfClass:[NSString class]]?5:[[[showedObject allValues] lastObject] intValue];
    
    [self.showedObject setValue:[NSNumber numberWithInt: MAX(0, value-1)] forKey:[[showedObject allKeys] lastObject]];
    
    self.rateLabel.text = [NSString stringWithFormat:@"%@", [[showedObject allValues] lastObject]];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        
        
        UIView *acce = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        self.accessoryView = acce;
        [acce release];
        
        self.rateLabel = [[[UILabel alloc] initWithFrame:acce.bounds] autorelease];
        [acce addSubview:rateLabel];
        rateLabel.textAlignment = UITextAlignmentCenter;
        rateLabel.backgroundColor = [UIColor clearColor];
        
        
        UIButton *plusButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 0, 50, 50)];
        [plusButton setTitle:@"+" forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(plus:) forControlEvents:UIControlEventTouchUpInside];
        [acce addSubview:plusButton];
        [plusButton release];
        plusButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];

        
        UIButton *minusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [minusButton setTitle:@"-" forState:UIControlStateNormal];
        [minusButton addTarget:self action:@selector(minus:) forControlEvents:UIControlEventTouchUpInside];
        [acce addSubview:minusButton];
        [minusButton release];
        minusButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
    }
    return self;
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
