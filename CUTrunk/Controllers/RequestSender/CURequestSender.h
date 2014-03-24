//
//  CURequestSender.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"


//uploadtype
typedef enum{
	UploadTypePicture = 0,
	UploadTypePhotoWall,
    UploadTypeVoice,
} UploadType;

@interface CURequestSender : AFHTTPClient
{
    NSString *requestUrl;
    NSDictionary *dictParam;
    id deletage;
    SEL completeSelector;
    SEL errorSelector;
    BOOL usePost;
}

@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, strong) NSDictionary *dictParam;
@property (nonatomic, strong) id delegate;
@property (nonatomic) SEL completeSelector;
@property (nonatomic) SEL errorSelector;
@property (nonatomic) SEL progressSelector;
@property (nonatomic, assign) BOOL usePost;
@property (nonatomic, assign)NSURLRequestCachePolicy cachePolicy;

@property (nonatomic, strong)UIImage *image;
@property (nonatomic, strong)NSString *filePath;

+ (id)requestSenderWithURL:(NSString *)theUrl
                   usePost:(BOOL)isPost
                     param:(NSDictionary *)dictParam
               cachePolicy:(NSURLRequestCachePolicy)cholicy
                  delegate:(id)theDelegate
          completeSelector:(SEL)theCompleteSelector
             errorSelector:(SEL)theErrorSelector
          selectorArgument:(id)theSelectorArgument;

- (void)send;
- (void)uploadData:(UploadType)type;
+ (instancetype)currentClient;
@end
