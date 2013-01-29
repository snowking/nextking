//
//  UIImage+NKImage.m
//  ZUO
//
//  Created by King on 1/29/13.
//  Copyright (c) 2013 King. All rights reserved.
//

#import "UIImage+NKImage.h"

@implementation UIImage (NKImage)



- (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets {
    UIImage *image = nil;
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        image = [self resizableImageWithCapInsets:capInsets];
        return image;
    }
    image = [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    return image;
}

@end
