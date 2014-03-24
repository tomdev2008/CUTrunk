//
//  CUFileClient.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUFileClient.h"
#import "Reachability.h"

@implementation CUFileClient

#pragma mark -
#pragma mark Client Functions


+ (instancetype)sharedInstance
{
    static CUFileClient *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}



#pragma mark - Login

- (id)init
{
    if(self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        
        Reachability * reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];

        
        [reach startNotifier];
    }
    
    return self;
}

- (int)getNetworkingType
{
    return nNetworkingType;
}

- (void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            nNetworkingType = 0;
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            nNetworkingType = 1;
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            nNetworkingType = 2;
            NSLog(@"正在使用wifi网络");
            break;
    }
}

#pragma mark 个人资料
/**
 * API:登录
 *
 * token，腾讯返回的token
 * login_type，登录类型
 */
- (void)loginByTencentOpenID:(NSString*)openid qq_token:(NSString*)qq_token device_id:(NSString *)device_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:qq_token forKey:@"qq_token"];
    [params setObject:openid forKey:@"openid"];
    
    if (device_id) {
        //[params setObject:device_id forKey:@"device_id"];
    }
    CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getLoginURL:@"login.php"]
                                                                   usePost:YES
                                                                     param:params
                                                               cachePolicy:cholicy
                                                                  delegate:theDelegate
                                                          completeSelector:theSelector
                                                             errorSelector:theSelectorError
                                                          selectorArgument:nil];
    [requestSender send];
}

/**
 * API:退出登录
 *
 * token
 */
- (void)logoutWithCachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError{
    NSString *token = [self getToken];
    if(token)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:token forKey:@"token"];

        CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getServerApiUrl:@"logout.php"]
                                                                       usePost:YES
                                                                         param:params
                                                                   cachePolicy:cholicy
                                                                      delegate:theDelegate
                                                              completeSelector:theSelector
                                                                 errorSelector:theSelectorError
                                                              selectorArgument:nil];
        [requestSender send];
    }
}

/**
 * API:获取个人资料
 *
 * user_id，(可选)，不填则是自己
 */
- (void)getUserProfile:(NSString*)userID cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    NSString *token = [self getToken];
    if(token)
    {
    
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:token forKey:@"token"];
        
        
        CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getServerApiUrl:@"user_profile_get.php"]
                                                                   usePost:YES
                                                                     param:params
                                                               cachePolicy:cholicy
                                                                  delegate:theDelegate
                                                          completeSelector:theSelector
                                                             errorSelector:theSelectorError
                                                          selectorArgument:nil];
        [requestSender send];
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
