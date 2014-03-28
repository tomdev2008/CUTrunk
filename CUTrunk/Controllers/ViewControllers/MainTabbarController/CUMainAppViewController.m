//
//  CUBaseTabbarViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUMainAppViewController.h"
#import "Global.h"
#import "UIAlertView+Addition.h"

@interface CUMainAppViewController()

@end

@implementation CUMainAppViewController

+ (instancetype)shareInstance
{
    static CUMainAppViewController *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setDelegate:self];
    
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"交友" image:[UIImage imageNamed:@"TabBarIconChatsOff"] finishedSelectedImage:[UIImage imageNamed:@"TabBarIconChatsOn"] viewClass:@"CUHomeViewController"],
                              [self viewControllerWithTabTitle:@"私信" image:[UIImage imageNamed:@"TabBarIconChatsOff"] finishedSelectedImage:[UIImage imageNamed:@"TabBarIconChatsOn"] viewClass:@"CUMessageViewController"],
                              [self viewControllerWithTabTitle:@"通讯录" image:[UIImage imageNamed:@"TabBarIconChatsOff"] finishedSelectedImage:[UIImage imageNamed:@"TabBarIconChatsOn"] viewClass:@"CUAddressViewController"],
                            [self viewControllerWithTabTitle:@"看点" image:[UIImage imageNamed:@"tabbar_find.png"]  finishedSelectedImage:[UIImage imageNamed:@"tabbar_find_tape.png"] viewClass:@"CUFindViewController"],
                            [self viewControllerWithTabTitle:@"我" image:[UIImage imageNamed:@"tabBarContactsIcon"] finishedSelectedImage:[UIImage imageNamed:@"tabBarContactsIcon"]  viewClass:@"CUPersonalViewController"],
                            nil];

    [self.tabBar setSelectionIndicatorImage:[[UIImage imageNamed:@"emptyIndicator.png"] stretchableImageWithLeftCapWidth:22 topCapHeight:22]];
    
    [self.tabBar setBackgroundImage:[[UIImage imageNamed:@"tabbar_background"] stretchableImageWithLeftCapWidth:1.5 topCapHeight:22]];
    [self.tabBar setBackgroundImage:[[UIImage imageNamed:@"tabbar_background"] stretchableImageWithLeftCapWidth:1.5 topCapHeight:22]];
    
    
    [self setSelectedViewController: self.viewControllers[0]];

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)navigationController
{
    UIViewController *viewController = ((UINavigationController*)navigationController).topViewController;
    if([viewController isKindOfClass:NSClassFromString(@"WPPersonalViewController")])
    {
        
        if(viewController.tabBarItem.badgeValue)
        {
            if([viewController respondsToSelector:@selector(clearSegmentStatus)])
            {
                [viewController performSelector:@selector(clearSegmentStatus) withObject:nil afterDelay:0];
            }
        }
    }
}

- (void)logoutButtonWasPressed
{
	NSLog(@"Logout Button Was Pressed");
}


- (void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
