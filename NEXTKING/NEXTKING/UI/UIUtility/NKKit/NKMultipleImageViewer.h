//
//  NKMultipleImageViewer.h
//  iSou
//
//  Created by King on 12-12-22.
//  Copyright (c) 2012年 King. All rights reserved.
//

#import "NKViewController.h"

@interface NKMultipleImageViewer : NKViewController <UIScrollViewDelegate>{
    
    NSArray   *imageObjects;
    NSInteger  currentIndex;
}

@property (nonatomic, retain) NSArray   *imageObjects;
@property (nonatomic, assign) NSInteger  currentIndex;

+(id)multipleImageViewerWithImages:(NSArray*)images;


#pragma mark - Navigation

- (NSInteger)currentPhotoIndex;
- (void)moveToPhotoAtIndex:(NSInteger)index animated:(BOOL)animated;


@end
