//
//  CUBaseController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUBaseController.h"

@interface CUBaseController ()

@end

@implementation CUBaseController

#pragma mark orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIViewController*)getVisibleViewController
{
    return nil;
}
#pragma mark Manage memory warning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    NSLog(@"*** %@: didReceiveMemoryWarning ***", [self class]);
    // Add code to clean up any of your own resources that are no longer necessary.
    
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidLoad
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        //self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}

@end
