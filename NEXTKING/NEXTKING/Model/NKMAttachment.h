//
//  NKMAttachment.h
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKModel.h"

@interface NKMAttachment : NKModel{
    
    NSString *type;
    
    NSString *title;
    NSString *description;
    
    NSString *link;
    NSString *playLink;
    
    NSString *pictureURL;
    NSString *thumbnailURL;
#if TARGET_OS_IPHONE
    UIImage  *picture;
    UIImage  *thumbnail;
#else //if TARGET_OS_MAC
    NSImage  *picture;
    NSImage  *thumbnail;
#endif
    
    BOOL downloadingPicture;
    BOOL downloadingThumbnail;
    
    ASIHTTPRequest *pictureRequest;
    ASIHTTPRequest *thumbnailRequest;
    
}


@property (nonatomic, retain) NSString *type;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;

@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *playLink;

@property (nonatomic, retain) NSString *pictureURL;
@property (nonatomic, retain) NSString *thumbnailURL;

#if TARGET_OS_IPHONE
@property (nonatomic, retain) UIImage  *picture;
@property (nonatomic, retain) UIImage  *thumbnail;
#else //if TARGET_OS_MAC
@property (nonatomic, retain) NSImage  *picture;
@property (nonatomic, retain) NSImage  *thumbnail;
#endif

@property (nonatomic, retain) ASIHTTPRequest *pictureRequest;
@property (nonatomic, retain) ASIHTTPRequest *thumbnailRequest;


// Download
@property (nonatomic, assign) BOOL downloadingPicture;
@property (nonatomic, assign) BOOL downloadingThumbnail;
-(void)downloadPicture;
-(void)downloadThumbnail;




@end
