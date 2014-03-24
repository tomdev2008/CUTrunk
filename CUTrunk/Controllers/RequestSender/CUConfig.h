//
//  CUConfig.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUConfig : NSObject

- (NSString *)getLoginURL:(NSString*)api;
- (NSString*)getServerApiUrl:(NSString*)api;
- (NSString*)getImageFromBaiduURL;
- (NSString*)getToken;
@end
