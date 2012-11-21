//
//  NKKVOImageView.h
//  ZUO
//
//  Created by King on 8/16/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKKVOImageView : UIImageView{
    
    id        modelObject;
    NSString *theKeyPath;
    
    id        target;
    SEL       renderMethod;
    SEL       singleTapped;
}

@property (nonatomic, retain) id        modelObject;
@property (nonatomic, retain) NSString *theKeyPath;

@property (nonatomic, assign) id        target;
@property (nonatomic, assign) SEL       renderMethod;
@property (nonatomic, assign) SEL       singleTapped;

@property (nonatomic, assign) UITapGestureRecognizer *tap;

-(void)bindValueOfModel:(id)mo forKeyPath:(NSString*)key;

@end
