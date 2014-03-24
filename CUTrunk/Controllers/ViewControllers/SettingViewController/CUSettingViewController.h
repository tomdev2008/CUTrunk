//
//  CUSettingViewController.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import "JMStaticContentTableViewController.h"

@interface CUSettingViewController : JMStaticContentTableViewController<SKStoreProductViewControllerDelegate,UIAlertViewDelegate>

+ (instancetype)shareInstance;
@end
