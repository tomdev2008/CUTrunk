//
//  CUModelApiViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//


#import "CUModelApiViewController.h"
#import "SBJson.h"
#import "CUFileClient.h"
#import "MobClick.h"


@implementation CUModelApiViewController
@synthesize model;


- (id)init{
    self = [super init]; 
    if (self) {
    }
    return self;
}

- (BOOL)isLoading {
    return loading;
}

// --- ---
- (NSURLRequestCachePolicy)getPolicy
{
    NSURLRequestCachePolicy getPolicy = NSURLRequestReloadRevalidatingCacheData;
    return getPolicy;
}

- (API_GET_TYPE)modelApi
{
    return -1;
}

- (void)loadMoreData:(NSNumber *)loadHeader
{
    BOOL loadMore = [loadHeader boolValue];
    
    [self loadData:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
              more:loadMore];
}

- (void)loadData:(NSURLRequestCachePolicy)cachePolicy more:(BOOL)more
{

    API_GET_TYPE api_type = [self modelApi];
    loading = YES;
    
    CUFileClient *client = [CUFileClient sharedInstance];
    int pageSize = [self getPageSize];//MODEL_PAGE_SIZE;
    int offset_id = more?offsetID:0;


//    switch (api_type) {
//            case API_SEARCH_IMAGE_LIST:
//            [client listSearchImage:[self getQuery] limit:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//            break;
//        
//            case API_HNDiscuz_SQUARE_LIST:
//            [client listAllHNDiscuz:pageSize offsetId:offset_id cachePolicy:cachePolicy  delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//            break;
//            
//            case API_HNDiscuz_NEARBY_LIST:
//            [client listNearbyHNDiscuz:[self getDistance] limit:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//            break;
//            
//            case API_HNDiscuz_MINE_LIST:
//            [client listMyHNDiscuz:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//            break;
//            
//            case API_HNDiscuz_HEARTED_LIST:
//            [client listHeartedHNDiscuz:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//            break;
//            
//            case API_REPLY_LIST:
//            [client listReplyOfHNDiscuz:[self getHNDiscuzID] limit:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_HNDiscuz_HOT_LIST:
//            [client listHotHNDiscuz:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_HNDiscuz_NEW_LIST:
//            [client listNewHNDiscuz:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_ADMIN_REPORTED_USER_LIST:
//            [client listReprotedUser:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_ADMIN_REPORTED_HNDiscuz_LIST:
//            [client listReprotedHNDiscuz:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_ADMIN_REPORTED_REPLY_LIST:
//            [client listReprotedReply:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_ADMIN_BLOCKED_USER_LIST:
//            [client listBlockedUser:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_NOTIFICATION_LIST:
//            [client listNotification:pageSize offsetId:offset_id cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//                break;
//            
//            case API_SEARCH_IMAGE_BAIDU_LIST:
//            [client listImageFromBaidu:pageSize offsetId:more?[self.model count]:0 text:[self getSearchText] cachePolicy:cachePolicy delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//            break;
//            
//        default:
//            break;
//        }
}

- (void)didFinishLoad:(id)object {
    
    if(object && [object isEqual: model])
    {
        return;
    }
    
    if (model) {
        // is loading more here
        [model addObjectsFromArray:object];
    } else {
        self.model = object;
    }
}

- (BOOL)shouldLoad {
    return !loading;
}

#pragma mark -
- (void)reloadData {
    
    if ([self shouldLoad] && ![self isLoading])
    {
        self.model = nil;
        [self loadData:NSURLRequestReloadIgnoringCacheData more:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:[self getPageName]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(self.model == nil)
    {
        [self reloadData];
    }

    [MobClick beginLogPageView:[self getPageName]];
}

- (NSString*)getPageName
{
    API_GET_TYPE api_type = [self modelApi];
    NSString *pageName = @"";
    
    switch (api_type) {
//        case API_HNDiscuz_SQUARE_LIST:
//            pageName = @"首页";
//            break;
//        case API_GET_IDENTIFY_LIST:
//            pageName = @"认同";
//            break;
//        case API_GET_RESPOND_LIST:
//            pageName = @"回应";
//            break;
//        case API_GET_MINE_LIST:
//            pageName = @"我的";
            break;
        
        default:
            break;
    }
    
    return pageName;
}

- (void)changeSence
{
    [[NSNotificationCenter defaultCenter] postNotificationName:AgainLoginNotification object:nil];
}

- (void)requestDidFinishLoad:(id)data
{
    if(data)
    {
        id obj = [data objectForKey:@"list"];
        if(obj && [obj isKindOfClass:[NSArray class]])
        {
            id offset_id = [data objectForKey:@"offset_id"];
            if(offset_id)
            {
                offsetID = [offset_id integerValue];
            }
            
            [self didFinishLoad:obj];
            loading = NO;
        }
    }
}

- (void)didFailWithError:(int)type
{
}

- (void)requestError:(NSError*)error
{
//    if ([error.domain isEqualToString:ERROR_DOMAIN]) {
//        //华鲁错误
//        NSString *reason = [error.userInfo objectForKey:@"reason"];
//        NSLog(@"reason:%@",reason);
//        
//    }else{
//        //其他错误
//    }
    
    loading = NO;
    [self didFailWithError:error.code];
}

#pragma mark subclass override
- (NSString *)getQuery {
    return @"";
}

- (NSString *)getHNDiscuzID
{
    return @"";
}

- (NSString *)getDistance
{
    return @"";
}

- (NSString*)getSearchText
{
    return @"";
}

- (NSInteger)getPageSize
{
    return 20;
}

#pragma mark
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    for (UIView __strong *subview in self.view.subviews) {
        subview = nil;
    }
}

@end
