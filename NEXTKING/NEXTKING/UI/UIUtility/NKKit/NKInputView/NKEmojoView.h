//
//  NKEmojoView.h
//  WEIMI
//
//  Created by King on 11/21/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKEmojoView : UIView{
    
    id textReciever;
    NSArray *emojoArray;
    
    
}
@property (nonatomic, assign) id textReciever;
@property (nonatomic, retain) NSArray *emojoArray;

+(id)emojoViewWithReciever:(id)reciever;

@end
