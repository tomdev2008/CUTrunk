//
//  CUModelApiViewController.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//


#include "CUBaseController.h"

#define MODEL_PAGE_SIZE 20

typedef enum
{
    API_HOME_LIST,               //附近
    API_FIND_LIST,               //
    API_RECOMEND_LIST,           //推荐
    API_NOTIFICATION_LIST,       //通知
    API_MESSAGE_LIST,       //私信

}API_GET_TYPE;

typedef enum
{
    ERROR_CODE_SUCCESS = 0,
    ERROR_CODE_NORMAL,
    ERROR_CODE_NEED_AUTH,
}API_GET_CODE;

@interface CUModelApiViewController : CUBaseController  {
    BOOL loading;
    int offsetID;
}

@property (nonatomic, retain) id model;

- (API_GET_TYPE)modelApi;

- (BOOL)shouldLoad;
- (BOOL)isLoading;
- (void)reloadData;

- (void)loadData:(NSURLRequestCachePolicy)cachePolicy more:(BOOL)more;
- (void)loadMoreData:(NSNumber *)loadHeader;

- (void)didFinishLoad:(id)object;
- (void)didFailWithError:(int)type;
- (void)requestDidFinishLoad:(NSData*)data;
- (void)requestError:(NSError*)error;


// subclass to override
- (NSString *)getQuery;
- (NSString *)getDistance;
- (NSString *)getSearchText;

- (NSInteger)getPageSize;
//- (int)getNoticeRange;
@end
