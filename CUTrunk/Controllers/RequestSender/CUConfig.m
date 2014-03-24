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

- (NSString *)getLoginURL:(NSString*)api
{
    return [NSString stringWithFormat:@"http://api.71ao.cn:9900/%@/%@",[self applicationVersion],api];;
}

- (NSString*)serverURL
{
    
    return [NSString stringWithFormat:@"http://%@:9900/",@"42.96.186.99"];//[[WPUserInfoDto sharedInstance] host]];
}

- (NSString*)applicationVersion
{
    return @"1";
}

- (NSString*)getServerApiUrl:(NSString*)api
{
    return [NSString stringWithFormat:@"%@%@/%@",[self serverURL],[self applicationVersion],api];
}

- (NSString*)getImageFromBaiduURL
{
    return @"http://image.baidu.com/i";
}

- (NSString*)getToken
{
    return @"";
//    NSString *string = [HNUserInfoDto sharedInstance].token;
//    return (string == nil || [string isEqualToString:@""])?nil:string;
}

@end
