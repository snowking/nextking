//
//  NKKVOLabel.h
//  LWUI
//
//  Created by King Connect on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 
The Render Method should be like
-(NSString*)stringWithNumber:(NSNumber*)number{
    return [NSString stringWithFormat:@"(%@)", number];
}
 
-(NSString*)stringWithValue:(id)value{
  return [NSString stringWithFormat:@"(%@)", value];
} 
*/
@interface NKKVOLabel : UILabel{
    id        modelObject;
    NSString *theKeyPath;
    
    id        target;
    SEL       renderMethod;
}

@property (nonatomic, retain) id        modelObject;
@property (nonatomic, retain) NSString *theKeyPath;

@property (nonatomic, assign) id        target;
@property (nonatomic, assign) SEL       renderMethod;

-(void)bindValueOfModel:(id)mo forKeyPath:(NSString*)key;

@end
