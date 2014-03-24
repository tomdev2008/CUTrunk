//
//  CULoginViewController.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "CUModelApiViewController.h"

@interface CULoginViewController : CUModelApiViewController<TencentLoginDelegate,TencentSessionDelegate>

+ (instancetype)shareInstance;
@property (nonatomic, strong) TencentOAuth *tencentOAuth;
@end
