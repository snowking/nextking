//
//  NKSegmentControl.h
//  ZUO
//
//  Created by King on 8/14/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum {
    NKSegmentControlDirectionPortrait,
    NKSegmentControlDirectionLandscape
} NKSegmentControlDirection;





@interface NKSegment : NSObject{
    UIImage  *normalBackground;
    UIImage  *selectedBackground;
    
    id title;
    
    
    CGSize segmentSize;
    UIColor *segmentColor;
    
}

@property (nonatomic, retain) UIImage *normalBackground;
@property (nonatomic, retain) UIImage *selectedBackground;

@property (nonatomic, retain) id title;

@property (nonatomic, assign) CGSize segmentSize;
@property (nonatomic, retain) UIColor *segmentColor;

+(id)segmentWithNormalBack:(UIImage*)normal selectedBack:(UIImage*)selected;
+(id)segmentWithNormalBack:(UIImage*)normal selectedBack:(UIImage*)selected andTitle:(id)atitle;
+(id)segmentWithSize:(CGSize)size color:(UIColor*)color andTitle:(id)atitle;

@end


@protocol NKSegmentControlDelegate;

@interface NKSegmentControl : UIView{
    
    NSInteger selectedIndex;
    NSArray  *segments;
    NSArray  *segmentImages;
    
    id <NKSegmentControlDelegate> delegate;
    
    BOOL shouldAnimate;
    
}
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, retain) NSArray  *segments;
@property (nonatomic, retain) NSArray  *segmentImages;

@property (nonatomic, assign) id <NKSegmentControlDelegate> delegate;

@property (nonatomic, assign) BOOL shouldAnimate;


-(void)selectSegment:(NSInteger)indexToSelect;
-(void)selectSegment:(NSInteger)indexToSelect shouldTellDelegate:(BOOL)should;

+(id)segmentControlViewWithSegments:(NSArray*)tempSegments;
+(id)segmentControlViewWithSegments:(NSArray*)tempSegments andDelegate:(id<NKSegmentControlDelegate>)adelegate;
+(id)segmentControlViewWithSegments:(NSArray*)tempSegments direction:(NKSegmentControlDirection)direction andDelegate:(id<NKSegmentControlDelegate>)adelegate;



@end


@protocol NKSegmentControlDelegate <NSObject>
@optional
-(void)segmentControl:(NKSegmentControl*)control didChangeIndex:(NSInteger)index;

@end

