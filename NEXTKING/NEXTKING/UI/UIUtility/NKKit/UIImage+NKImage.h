//
//  UIImage+NKImage.h
//  ZUO
//
//  Created by King on 1/29/13.
//  Copyright (c) 2013 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NKImage)

- (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets;

@end



@interface UIViewController (NKPresent)

- (void)presentNKViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion;

- (void)dismissNKViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;


@end
