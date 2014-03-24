//
//  CUBaseTabbarViewController.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUBaseTabbarViewController : UITabBarController

- (id)viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image finishedSelectedImage:(UIImage*)finishedSelectedImage viewClass:(NSString*)viewClass;
- (UIViewController*)viewControllerWithSubClass:(NSString*)viewClass;
- (void)addHNDiscuzButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;

@end
