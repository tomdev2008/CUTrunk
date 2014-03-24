//
//  CURequestSender.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CURequestSender.h"
#import "AFHTTPRequestOperation.h"
#import "CUFileClient.h"
#import "SBJson.h"

static const float TIME_OUT_INTERVAL = 30.0f;

typedef enum
{
    ERROR_CODE_SUCCESS = 0,
    ERROR_CODE_NORMAL,
    ERROR_CODE_NEED_AUTH,
}API_GET_CODE;

@implementation CURequestSender
@synthesize progressSelector;
@synthesize requestUrl;
@synthesize usePost;
@synthesize dictParam;
@synthesize delegate;
@synthesize completeSelector;
@synthesize errorSelector;
@synthesize cachePolicy;
@synthesize filePath;

+ (instancetype)currentClient
{
    static CURequestSender *sharedInstance = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        sharedInstance = [[CURequestSender alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        [sharedInstance.operationQueue setMaxConcurrentOperationCount:1];
    });
    return sharedInstance;
}

+ (id)requestSenderWithURL:(NSString *)theUrl
                   usePost:(BOOL)isPost
                     param:(NSDictionary *)dictParam
               cachePolicy:(NSURLRequestCachePolicy)cholicy
                  delegate:(id)theDelegate
          completeSelector:(SEL)theCompleteSelector
             errorSelector:(SEL)theErrorSelector
          selectorArgument:(id)theSelectorArgument
{
    CURequestSender *requestSender = [[CURequestSender alloc] init];
    requestSender.requestUrl = theUrl;
    requestSender.usePost = isPost;
    requestSender.dictParam = dictParam;
    requestSender.delegate = theDelegate;
    requestSender.completeSelector = theCompleteSelector;
    requestSender.errorSelector = theErrorSelector;
    requestSender.cachePolicy = cholicy;
    NSLog(@"%@ \n %@", theUrl, dictParam);
    return requestSender;
    
}

- (void)send
{
    NSMutableString *queryStr = [[NSMutableString alloc] init];
    for (int i = 0; i < [dictParam count]; ++i)
    {
        NSString *key = [dictParam allKeys][i];
        NSString *value = [dictParam allValues][i];
        
        if(value && [value isKindOfClass:[NSString class]])
        {
            NSString *encodedValue = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                  (CFStringRef)value,
                                                                                                  NULL,
                                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                  kCFStringEncodingUTF8);
            [queryStr appendFormat:@"&%@=%@", key, encodedValue];
            
        }
        else
        {
            [queryStr appendFormat:@"&%@=%@", key, value];
            
        }
    }
    
  
    if(!usePost)
    {
        self.requestUrl = [self.requestUrl stringByAppendingString:[NSString stringWithFormat:@"?%@",queryStr]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]
                                                           cachePolicy:self.cachePolicy//NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:TIME_OUT_INTERVAL];
    
 
    
    [request setHTTPMethod:usePost?@"POST":@"GET"];
    if(usePost)
    {
        [request setHTTPBody:[queryStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //缓存
    id responseObject = [self getCacheData:[self.requestUrl stringByAppendingString:queryStr]];
    //判断是否有缓存
    if (responseObject != nil && self.delegate && self.completeSelector)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id object = [self transitionData:responseObject];
        [self.delegate performSelector:self.completeSelector withObject:object];
#pragma clang diagnostic pop
    }
    
        
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(self.delegate && self.completeSelector)
        {
            if([self.delegate respondsToSelector:self.completeSelector])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         
                //去皮
                id object = [self transitionData:responseObject];
                
                if (object) {
                    if ([object isKindOfClass:[NSError class]]) {
                        [self.delegate performSelector:self.errorSelector withObject:(NSError *)object];
                    }else{
                        [self dealCacheData:responseObject queryStr:[self.requestUrl stringByAppendingString:queryStr]];
                        [self.delegate performSelector:self.completeSelector withObject:object];
                    }
                }
#pragma clang diagnostic pop
            }
        }
        
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        if(self.delegate && self.errorSelector)
        {
            if([self.delegate respondsToSelector:self.errorSelector])
            {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self.delegate performSelector:self.errorSelector withObject:error];
#pragma clang diagnostic pop
                
            }
        }
        
	}];
	
	[operation start];
}

+ (void)cancelCurrentUploadRequest
{
    for (NSOperation *operation in [[[CURequestSender currentClient] operationQueue] operations])
    {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]])
            continue;
        [operation cancel];
    }
}

+ (void)cancelAllHTTPOperations
{}

- (id)getCacheData:(NSString*)requestString
{
    NSString *limit = [self.dictParam objectForKey:@"limit"];
    NSString *offset_id = [self.dictParam objectForKey:@"offset_id"];
    
    if(limit && offset_id)
    {
        if(0 == [offset_id intValue])
        {
            id responseObject = [[NSUserDefaults standardUserDefaults] objectForKey:requestString];
            
            return responseObject;
        }
    }
    
    return nil;
}

- (id)dealCacheData:(NSDictionary*)responseObject queryStr:(NSString*)requestString
{
    NSString *limit = [self.dictParam objectForKey:@"limit"];
    NSString *offset_id = [self.dictParam objectForKey:@"offset_id"];

    if(limit && offset_id)
    {
        BOOL isMore = offset_id.intValue > 0?YES:NO;
        if(!isMore)
        {
            if(responseObject)
            {
                [[NSUserDefaults standardUserDefaults] setObject:responseObject forKey:requestString];
            }
        }
        
        return responseObject;
        
    }
    
    //非list得员数据
    return responseObject;

}
///////////////
- (id)transitionData:(NSData*)data
{
    NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    json_string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

    NSLog(@"%@", [json_string JSONValue]);
    if(json_string.length > 0)
    {
        NSDictionary *dict = [json_string JSONValue];
        
        NSString *code = [dict objectForKey:@"code"];
        if (code && ERROR_CODE_NEED_AUTH == [code intValue]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:AgainLoginNotification object:nil];
        }else if (code && ERROR_CODE_NORMAL == [code intValue]) {
            NSError *error = [NSError errorWithDomain:ERROR_DOMAIN code:[code intValue] userInfo:[NSDictionary dictionaryWithObject:[[json_string JSONValue] objectForKey:@"data"] forKey:@"reason"]];

            return error;
        }else if (code && ERROR_CODE_SUCCESS == [code intValue]){
            id responseObject = [[json_string JSONValue] objectForKey:@"data"];
            return responseObject;
        }else{
            NSError *error = [NSError errorWithDomain:@"unknow" code:1024 userInfo:nil];
            
            return error;
        }
    }
    
    return nil;
}

@end