//
//  NKSegmentControl.m
//  ZUO
//
//  Created by King on 8/14/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKSegmentControl.h"

#define NormalTextColor [UIColor blackColor]
#define HighlightTextColor [UIColor whiteColor]

@implementation NKSegment

@synthesize normalBackground;
@synthesize selectedBackground;
@synthesize title;

@synthesize segmentSize;
@synthesize segmentColor;
@synthesize highlightSegmentColor;

@synthesize normalTextColor;
@synthesize highlightTextColor;

-(void)dealloc{
    
    [normalBackground release];
    [selectedBackground release];
    [title release];
    
    [segmentColor release];
    [highlightSegmentColor release];
    
    [normalTextColor release];
    [highlightTextColor release];
    
    [super dealloc];
}


+(id)segmentWithNormalBack:(UIImage*)normal selectedBack:(UIImage*)selected{
    return [self segmentWithNormalBack:normal selectedBack:selected andTitle:nil];
}

+(id)segmentWithNormalBack:(UIImage*)normal selectedBack:(UIImage*)selected andTitle:(id)atitle{
    
    return [self segmentWithNormalBack:normal selectedBack:selected title:atitle normalTextColor:nil andHighlightTextColor:nil];
    
}

+(id)segmentWithNormalBack:(UIImage*)normal selectedBack:(UIImage*)selected title:(id)atitle normalTextColor:(UIColor*)nColor andHighlightTextColor:(UIColor*)hColor{
    
    NKSegment *newSegment = [[self alloc] init];
    
    newSegment.normalBackground = normal;
    newSegment.selectedBackground = selected;
    newSegment.title = atitle;
    
    if (nColor) {
        newSegment.normalTextColor = nColor;
    }
    if (hColor) {
        newSegment.highlightTextColor = hColor;
    }
    
    return [newSegment autorelease];
    
}


+(id)segmentWithSize:(CGSize)size color:(UIColor*)color andTitle:(id)atitle{
    
    return [self segmentWithSize:size normalColor:color highlightColor:nil andTitle:atitle];
}

+(id)segmentWithSize:(CGSize)size normalColor:(UIColor*)ncolor highlightColor:(UIColor*)hColor andTitle:(id)atitle{
    
    NKSegment *newSegment = [[self alloc] init];
    newSegment.segmentSize = size;
    newSegment.title = atitle;
    
    if (ncolor) {
        newSegment.segmentColor = ncolor;
    }
    if (hColor) {
        newSegment.highlightSegmentColor = hColor;
    }
    
    return [newSegment autorelease];
    
    
}

-(id)init{
    
    self = [super init];
    if (self) {
        
        self.normalTextColor = NormalTextColor;
        self.highlightTextColor = HighlightTextColor;
        
        self.segmentColor = [UIColor clearColor];
        self.highlightSegmentColor = [UIColor clearColor];
        
    }
    
    return self;
}

@end





@implementation NKSegmentControl

@synthesize selectedIndex;
@synthesize segments;
@synthesize segmentImages;
@synthesize delegate;
@synthesize shouldAnimate;

-(void)dealloc{
    
    [segments release];
    [segmentImages release];
    
    [super dealloc];
}



+(id)segmentControlViewWithSegments:(NSArray*)tempSegments{
    return [self segmentControlViewWithSegments:tempSegments andDelegate:nil];
}
+(id)segmentControlViewWithSegments:(NSArray*)tempSegments andDelegate:(id<NKSegmentControlDelegate>)adelegate{
    
    return [self segmentControlViewWithSegments:tempSegments direction:NKSegmentControlDirectionLandscape andDelegate:adelegate];
    
}

+(id)segmentControlViewWithSegments:(NSArray*)tempSegments direction:(NKSegmentControlDirection)direction andDelegate:(id<NKSegmentControlDelegate>)adelegate{
    
    NKSegmentControl *newSC = [[NKSegmentControl alloc] init];
    newSC.selectedIndex = 0;
    
    NSMutableArray *buttonSegments = [NSMutableArray arrayWithCapacity:[tempSegments count]];
    
    UIButton *newSegment = nil;
    UIImage *normalImage = nil;
    CGFloat totalWidth = 0.0;
    CGFloat totalHeight = 0.0;
    NSInteger currentIndex = 0;
    
    for (NKSegment *segment in tempSegments) {
        normalImage = segment.normalBackground;
        
        newSegment = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if ([segment.title isKindOfClass:[NSString class]]) {
            [newSegment setTitle:segment.title forState:UIControlStateNormal];
        }
        else if ([segment.title isKindOfClass:[UIImage class]]) {
            [newSegment setImage:segment.title forState:UIControlStateNormal];
        }
        
        // Set Style
        newSegment.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        //newSegment.titleLabel.shadowColor = [UIColor whiteColor];
        //newSegment.titleLabel.shadowOffset = CGSizeMake(0, 1);
        //newSegment.reversesTitleShadowWhenHighlighted = YES;
        [newSegment setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newSegment setTitleShadowColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [newSegment setTitleColor:NormalTextColor forState:UIControlStateNormal];
        [newSegment setTitleColor:HighlightTextColor forState:UIControlStateHighlighted];
        
        newSegment.tag = currentIndex;
        [newSegment setBackgroundImage:currentIndex==0?segment.selectedBackground:segment.normalBackground forState:UIControlStateNormal];
        [newSegment addTarget:newSC action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
        [newSC addSubview:newSegment];
        newSegment.adjustsImageWhenHighlighted = NO;
        
        [buttonSegments addObject:newSegment];
        
        
        
        switch (direction) {
            case NKSegmentControlDirectionLandscape:{
                newSegment.frame = CGRectMake(totalWidth, 0, normalImage?normalImage.size.width:segment.segmentSize.width, normalImage?normalImage.size.height:segment.segmentSize.height);
                currentIndex++;
                totalWidth+=newSegment.frame.size.width;
                if (newSegment.frame.size.height>totalHeight) {
                    totalHeight = newSegment.frame.size.height;
                }
            }
                break;
            case NKSegmentControlDirectionPortrait:{
                newSegment.frame = CGRectMake(0, totalHeight, normalImage?normalImage.size.width:segment.segmentSize.width, normalImage?normalImage.size.height:segment.segmentSize.height);
                currentIndex++;
                totalHeight+=newSegment.frame.size.height;
                if (newSegment.frame.size.width>totalWidth) {
                    totalWidth = newSegment.frame.size.width;
                }
            }
                break;
            default:
                break;
        }
        
        

    }
    
    
    newSC.frame = CGRectMake(0, 0, totalWidth, totalHeight);
    newSC.segments = buttonSegments;
    newSC.segmentImages = tempSegments;
    
    newSC.delegate = adelegate;
    
    [newSC selectSegment:0 shouldTellDelegate:NO];
    
    return [newSC autorelease];
    
}

-(void)deSelectAll{
    for (UIButton *segment in self.segments) {
        
        NKSegment *nkseg = [self.segmentImages objectAtIndex:segment.tag];
        [[segment subviews] makeObjectsPerformSelector:@selector(setHighlighted:) withObject:NO];
        [segment setBackgroundImage:nkseg.normalBackground forState:UIControlStateNormal];
        [segment setTitleColor:nkseg.normalTextColor forState:UIControlStateNormal];
        
        if (!nkseg.selectedBackground && !nkseg.normalBackground) {
            segment.backgroundColor = nkseg.segmentColor;
        }
        
    }
    
}

-(void)selectSegment:(NSInteger)indexToSelect shouldTellDelegate:(BOOL)should{
    
    [self deSelectAll];
    selectedIndex = indexToSelect;
    
    if (indexToSelect<0 || indexToSelect>=[self.segments count]) {
        return;
    }
    
    UIButton *nkseg = [self.segments objectAtIndex:selectedIndex];
    
    [[nkseg subviews] makeObjectsPerformSelector:@selector(setHighlighted:) withObject:(id)YES];
    
    NKSegment *theSeg = [self.segmentImages objectAtIndex:selectedIndex];

    [nkseg setBackgroundImage:[theSeg selectedBackground] forState:UIControlStateNormal];
    [nkseg setTitleColor:[theSeg highlightTextColor] forState:UIControlStateNormal];
    
    if (!theSeg.selectedBackground && !theSeg.normalBackground) {
        nkseg.backgroundColor = theSeg.highlightSegmentColor;
    }
    
    if (shouldAnimate) {
        nkseg.alpha = 0.3;
        [UIView animateWithDuration:0.3 animations:^{
            nkseg.alpha = 1.0;
        }];

    }
    
    if (should && [delegate respondsToSelector:@selector(segmentControl:didChangeIndex:)]) {
        [delegate segmentControl:self didChangeIndex:selectedIndex];
    }

    
}

-(void)selectSegment:(NSInteger)indexToSelect{
    
    [self selectSegment:indexToSelect shouldTellDelegate:YES];
}



-(void)buttonClicked:(UIButton*)button{
    
    if (button.tag == selectedIndex) {
        return;
    }
    
    [self selectSegment:button.tag];
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
