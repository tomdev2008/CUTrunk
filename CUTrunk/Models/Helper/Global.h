//
//  Global.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UIView+Addition.h"
#import "UIBarButtonItem+Addition.h"
#import "UIColor+Addition.h"
#import "UIFont+Addtion.h"
#import "NSArray+Addition.h"
#import "UIAlertView+Addition.h"
#import "NSString+Addition.h"
#import "NSDate+Addition.h"
#import "UIDevice+Hardware.h"
#import "Colours.h"
#import "SVProgressHUD.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define ERROR_DOMAIN @"huainanhai"
extern NSString*  const AgainLoginNotification;

@interface Global : NSObject

UINavigationController *selected_navigation_controller();
@end

@interface UIColor (RGB)
+ (UIColor *)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b;
@end
