//
//  CUBaseTabbarViewController.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUBaseTabbarViewController.h"

@interface CUMainAppViewController : CUBaseTabbarViewController<UITabBarControllerDelegate ,UIAlertViewDelegate>

+ (instancetype)shareInstance;
- (void)markItemBadge:(NSString *)badge;

@end
