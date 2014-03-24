//
//  CUBaseTabbarViewController
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUBaseTabbarViewController.h"

@implementation CUBaseTabbarViewController

- (id)viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image finishedSelectedImage:(UIImage*)finishedSelectedImage viewClass:(NSString*)viewClass
{   
    Class viewControllerClass = NSClassFromString(viewClass);
    UIViewController* viewController = [[viewControllerClass alloc] init];
    //viewController.title = title;
    [viewController.tabBarItem setSelectedImage:finishedSelectedImage];
    [viewController.tabBarItem setImage:image];
    [viewController setTitle:title];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:1. green:102./225. blue:0 alpha:1.] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    return navigationController;
}

- (UIViewController*)viewControllerWithSubClass:(NSString*)viewClass
{   
    Class viewControllerClass = NSClassFromString(viewClass);
    UIViewController* viewController = [[viewControllerClass alloc] init];
    return viewController;
}

- (void)addHNDiscuzButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    //changed by kevin
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];

    button.frame = CGRectMake(self.tabBar.width/[self.viewControllers count], 0, self.tabBar.width / [self.viewControllers count], self.tabBar.height);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 3, 0);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(centerButtonclicked:) forControlEvents:UIControlEventTouchDown];
    
    [self.tabBar addSubview:button];

}

- (void)centerButtonclicked:(id)sender
{
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
