//
//  NKProgressView.h
//  ZUO
//
//  Created by King on 12/10/12.
//  Copyright (c) 2012 King. All rights reserved.
//

#import "MBProgressHUD.h"


#define HideTime 0.2

#define Progress(word) progressView = [NKProgressView progressView];progressView.labelText = word;

#define ProgressLoading progressView = [NKProgressView progressViewForView:self.contentView];\
progressView.labelText = @"正在载入..."

#define ProgressHide if (progressView){ [progressView hide:YES afterDelay:0.3]; progressView = nil;}

#define ProgressSuccess(word) if (progressView) {[progressView successWithString:word];progressView = nil;}

#define ProgressFailedWith(word)  if(!progressView){progressView = [NKProgressView progressView];}if (progressView){ progressView = [progressView failedWithString:word];progressView = nil; }
#define ProgressFailed  if(!progressView){progressView = [NKProgressView progressView];}if (progressView){ progressView = [progressView failedWithString:@"连接失败，请重试"];progressView = nil; }
#define ProgressNetWorkError if(!progressView){progressView = [NKProgressView progressView];}if (progressView){ progressView = [progressView netWorkError];progressView = nil;}


#define ProgressErrorDefault if(!progressView){progressView = [NKProgressView progressView];}if (progressView){ progressView = [progressView failedWithString:request.errorCode?[request.errorCode description]:@"网络未连接，请检查设置"];progressView = nil; }
#define ProgressAlertView ProgressHide; UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:ticket.serverError?[ticket.serverError descriptionForUI]:@"网络未连接，请检查设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alert show];[alert release]

@interface NKProgressView : MBProgressHUD


+(id)progressView;

+(id)progressViewForView:(UIView*)view;

+(id)loadingViewForView:(UIView*)view;


-(id)netWorkError;
-(id)failedWithString:(NSString*)string;

-(id)successWithString:(NSString*)string;

@end
