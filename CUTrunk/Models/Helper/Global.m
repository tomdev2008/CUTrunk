//
//  Global.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "Global.h"

NSString *const AgainLoginNotification = @"com.again.login";


@implementation Global

UINavigationController *selected_navigation_controller()
{
//    if((UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController.presentedViewController)
//        return (UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController.parentViewController;
//    else
        return  (UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController;
        
}
@end

@implementation UIColor (RGB)
+ (UIColor *)colorWithRed:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b {
    return [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.];
}
@end
