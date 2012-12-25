//
//  NKMAttachment.m
//  NEXTKING
//
//  Created by King on 10/24/12.
//  Copyright (c) 2012 ZUO.COM. All rights reserved.
//

#import "NKMAttachment.h"

NSString *const NKAttachmentTypeMan = @"man";
NSString *const NKAttachmentTypePicture = @"picture";

@implementation NKMAttachment

@synthesize type;

@synthesize title;
@synthesize description;

@synthesize link;
@synthesize playLink;

@synthesize pictureURL;
@synthesize thumbnailURL;

@synthesize picture;
@synthesize thumbnail;

@synthesize downloadingPicture;
@synthesize downloadingThumbnail;

@synthesize pictureRequest;
@synthesize thumbnailRequest;


-(void)dealloc{
    
    [type release];
    
    [title release];
    [description release];
    
    [link release];
    [playLink release];
    
    [pictureURL release];
    [thumbnailURL release];

    [picture release];
    [thumbnail release];
    
    [pictureRequest clearDelegatesAndCancel];
    [thumbnailRequest clearDelegatesAndCancel];
    
    [pictureRequest release];
    [thumbnailRequest release];
    
    [super dealloc];
}

//-(NSString*)description{
//
//    return [NSString stringWithFormat:@"<%@> pictureURL:%@, type:%@, thumbnailURL:%@", NSStringFromClass([self class]), pictureURL, [NSNumber numberWithInt:type], thumbnailURL];
//}


+(id)modelFromDic:(NSDictionary *)dic{
    
    NKMAttachment *newAtt = [super modelFromDic:dic];
    
    NKBindValueWithKeyForParameterFromDic(@"type", newAtt.type, dic);
    
    NKBindValueWithKeyForParameterFromDic(@"title", newAtt.title, dic);
    NKBindValueWithKeyForParameterFromDic(@"description", newAtt.description, dic);
    
    NKBindValueWithKeyForParameterFromDic(@"link", newAtt.link, dic);
    NKBindValueWithKeyForParameterFromDic(@"play_link", newAtt.playLink, dic);
    
    NKBindValueWithKeyForParameterFromDic(@"picture", newAtt.pictureURL, dic);
    NKBindValueWithKeyForParameterFromDic(@"thumbnail", newAtt.thumbnailURL, dic);
    

    return newAtt;
}



#if TARGET_OS_IPHONE
-(UIImage*)picture{
    if (!picture) {
        if (!self.downloadingPicture) {
            [self downloadPicture];
        }
        //return [UIImage imageNamed:@"default_portrait.png"];
        
    }
    return picture;
}
-(void)downLoadPictureFinish:(ASIHTTPRequest*)request{
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        UIImage *picImage = [UIImage imageWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
        if (picImage) {
            self.picture = picImage;
            self.downloadingPicture = YES;
        }
        
        self.pictureRequest = nil;
    });
    
    
}
-(UIImage*)thumbnail{
    if (!thumbnail) {
        if (!self.downloadingThumbnail) {
            [self downloadThumbnail];
        }
        //return [UIImage imageNamed:@"default_portrait.png"];
        
    }
    return thumbnail;
}
-(void)downLoaThumbnailFinish:(ASIHTTPRequest*)request{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        UIImage *thumbImage = [UIImage imageWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]];
        if (thumbImage) {
            self.thumbnail = thumbImage;
            self.downloadingThumbnail = YES;
        }
        
        self.thumbnailRequest = nil;
    });
}
#else

-(NSImage*)picture{
    if (!picture) {
        if (!self.downloadingPicture) {
            [self downloadPicture];
        }
        //return [UIImage imageNamed:@"default_portrait.png"];
        
    }
    return picture;
}
-(void)downLoadPictureFinish:(ASIHTTPRequest*)request{
    
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSImage *picImage = [[[NSImage alloc] initWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]] autorelease];
        if (picImage) {
            self.picture = picImage;
            self.downloadingPicture = YES;
        }
        self.pictureRequest = nil;
    });
    
    
}
-(NSImage*)thumbnail{
    if (!thumbnail) {
        if (!self.downloadingThumbnail) {
            [self downloadThumbnail];
        }
        //return [UIImage imageNamed:@"default_portrait.png"];
        
    }
    return thumbnail;
}
-(void)downLoaThumbnailFinish:(ASIHTTPRequest*)request{
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSImage *thumbImage = [[[NSImage alloc] initWithContentsOfFile:[[ASIDownloadCache sharedCache] pathToStoreCachedResponseDataForRequest:request]] autorelease];
        if (thumbImage) {
            self.thumbnail = thumbImage;
            self.downloadingThumbnail = YES;
        }
        self.thumbnailRequest = nil;
    });
    
    
}

#endif

-(void)downloadPicture{
    if (self.downloadingPicture || !self.pictureURL) {
        return;
    }
    self.downloadingPicture = YES;
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.pictureURL]]];
    self.pictureRequest = request;
    request.delegate = self;
    [request setDidFinishSelector:@selector(downLoadPictureFinish:)];
    [request setDidFailSelector:@selector(downLoadPictureFailed:)];
    [request startAsynchronous];
    
}
-(void)downloadThumbnail{
    
    if (self.downloadingThumbnail || !self.thumbnailURL) {
        return;
    }
    self.downloadingThumbnail = YES;
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithImageURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.pictureURL]]];
    self.thumbnailRequest = request;
    request.delegate = self;
    [request setDidFinishSelector:@selector(downLoaThumbnailFinish:)];
    [request setDidFailSelector:@selector(downloadThumbnailFailed:)];
    [request startAsynchronous];
    
    
}
-(void)downloadThumbnailFailed:(ASIHTTPRequest*)request{
    self.downloadingThumbnail = NO;
    self.thumbnailRequest = nil;
    
}

-(void)downLoadPictureFailed:(ASIHTTPRequest*)request{
    self.downloadingPicture = NO;
    self.pictureRequest = nil;
}

@end
