//
//  CUConfig.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUConfig.h"
#import "CUUserInfoDto.h"

@implementation CUConfig

- (NSString*)serverURL
{
    return @"http://ciao.cuapp.me/";
}

- (NSString*)applicationVersion
{
    return @"v1";
}

- (NSString*)getServerApiUrl:(NSString*)api
{
    return [NSString stringWithFormat:@"%@%@/%@",[self serverURL],[self applicationVersion],api];
}

- (NSString*)getTicket
{
    return @"";
}

@end
