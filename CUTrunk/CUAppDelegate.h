//
//  CUAppDelegate.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUMainAppViewController.h"
#import "MobClick.h"

@interface CUAppDelegate : UIResponder <UIApplicationDelegate,MobClickDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CUMainAppViewController *mainController;

+ (CUAppDelegate *)shareInstance;
- (void)loginSucessed;
@end
