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
 * ticket 票
 * login_type，登录类型
 */
- (void)loginUserSystem:(NSString*)email password:(NSString*)password cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:email forKey:@"email"];
    [params setObject:password forKey:@"password"];

    CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getServerApiUrl:@"user/auth"]
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
 * API:用户注册
 *
 * ticket
 */
- (void)registerUserSystem:(NSString*)email password:(NSString*)password username:(NSString*)username description:(NSString*)description cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:email forKey:@"email"];
    [params setObject:password forKey:@"password"];
    [params setObject:username forKey:@"name"];
    [params setObject:description forKey:@"description"];
    //[params setObject:headImageId forKey:@"headImageId"];

    CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getServerApiUrl:@"user/register"]
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
 * ticket
 */
- (void)logoutByUserTicket:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    NSString *ticket = [self getTicket];
    if(ticket)
    {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:ticket forKey:@"ticket"];

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
- (void)getUserProfile:(NSString*)user_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:user_id forKey:@"id"];
    
    
    CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getServerApiUrl:@"user/profile/view"]
                                                               usePost:NO
                                                                 param:params
                                                           cachePolicy:cholicy
                                                              delegate:theDelegate
                                                      completeSelector:theSelector
                                                         errorSelector:theSelectorError
                                                      selectorArgument:nil];
    [requestSender send];
    
}

/**
 * API:更新个人资料
 *
 *
 */
- (void)updateUserProfile:(NSString*)username birthday:(NSString*)birthday height:(int)height  weight:(int)weight city:(NSString*)city description:(NSString*)description favorTag:(NSString*)favor_tag image:(NSArray*)image_array pushNearbyHNDiscuz:(NSString*)push_nearby_HNDiscuz cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:username forKey:@"username"];
    [params setObject:birthday forKey:@"birthday"];
    [params setObject:[NSNumber numberWithInt:height] forKey:@"height"];
    [params setObject:[NSNumber numberWithInt:weight] forKey:@"weight"];
    [params setObject:city forKey:@"city"];
    [params setObject:description forKey:@"description"];
    [params setObject:favor_tag forKey:@"favor_tag"];
    //[params setObject:@"" forKey:@"image"];

    
    CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getServerApiUrl:@"user/profile/modify"]
                                                                   usePost:YES
                                                                     param:params
                                                               cachePolicy:cholicy
                                                                  delegate:theDelegate
                                                          completeSelector:theSelector
                                                             errorSelector:theSelectorError
                                                          selectorArgument:nil];
    [requestSender send];
}

- (void)listNearUser:(double)longitude latitude:(double)latitude limit:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];
    [params setObject:[NSNumber numberWithDouble:latitude]  forKey:@"latitude"];
    [params setObject:[NSNumber numberWithInt:limit] forKey:@"limit"];
    [params setObject:[NSNumber numberWithInt:offset_id] forKey:@"offset_id"];

  
    CURequestSender *requestSender = [CURequestSender requestSenderWithURL:[self getServerApiUrl:@"lbs/near/user"]
                                                                   usePost:NO
                                                                     param:params
                                                               cachePolicy:cholicy
                                                                  delegate:theDelegate
                                                          completeSelector:theSelector
                                                             errorSelector:theSelectorError
                                                          selectorArgument:nil];
    [requestSender send];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
