//
//  CUUserInfoDto.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelBase.h"

@interface CUUserInfoDto : DataModelBase
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *role;
@property (nonatomic, copy) NSString *visit_password;
@property (nonatomic, assign) BOOL push_on_reply;
@property (nonatomic, assign) BOOL push_on_like;
@property (nonatomic, assign) BOOL push_nearby_HNDiscuz;
@property (nonatomic, assign) NSInteger reply_limit;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *invite_code;
@property (nonatomic, assign) NSInteger invite_count;
@property (nonatomic, assign) BOOL invited;


+ (instancetype)sharedInstance;
+ (void)saveUserInfo:(CUUserInfoDto *)loginUserInfo;
+ (void)cleanAccountDTO;
+ (void)activeLoginUserInfo;
+ (CUUserInfoDto *)loginUserInfo;

@end
