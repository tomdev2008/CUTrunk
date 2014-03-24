//
//  CUAppDelegate.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUAppDelegate.h"
#import "CUMainAppViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "CULoginViewController.h"
#import "MobClick.h"
#import "CULoginViewController.h"
#import "CUFileClient.h"

@implementation CUAppDelegate
@synthesize mainController = _mainController;


+ (CUAppDelegate*)shareInstance{
    
    return (CUAppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    
    if(1)
    {
        self.mainController = [[CUMainAppViewController alloc] init];
        [self.window setRootViewController:_mainController];
    }
    else
    {
        CULoginViewController *loginViewController = [CULoginViewController shareInstance];
        [self.mainController.view addSubview:loginViewController.view];
        
    }
    
    
    [self.window makeKeyAndVisible];
    
    //平台账号
    [MobClick startWithAppkey:@"530ea90356240bc082094dca" reportPolicy:SEND_INTERVAL channelId:@"appStore"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againLogin) name:AgainLoginNotification object:nil];
    
    
    [application setMinimumBackgroundFetchInterval:5];
    return YES;
}

- (void)loginSucessed
{
    self.mainController = [[CUMainAppViewController alloc] init];
    [self.window setRootViewController:_mainController];
    //登录后，提示Push通知
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert)];
    
}

- (void)againLogin
{
    self.mainController = nil;
    CULoginViewController *loginViewController = [CULoginViewController shareInstance];
    [self.window setRootViewController:loginViewController];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    NSString *text = [url absoluteString];
    
    NSRange range = [text rangeOfString:@"tencent"];//判断字符串是否包含
    if (range.location == NSNotFound)
    {
    }
    
    
    return [TencentOAuth HandleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    static UIBackgroundTaskIdentifier task;
    
    task = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        [application endBackgroundTask:task];
        task = UIBackgroundTaskInvalid;
    }];
    
    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Do the work associated with the task, preferably in chunks.
        [application endBackgroundTask:task];
        task = UIBackgroundTaskInvalid;
    });
    
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    
    if([self.window.rootViewController isKindOfClass:[CUMainAppViewController class]])
    {
        
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //    //tabbaritem上标记数字
    //    if ([self.window.rootViewController isKindOfClass:[WPMainAppViewController class]]
    //        && [[UIApplication sharedApplication] applicationIconBadgeNumber]>0) {
    //        [(WPMainAppViewController *)self.window.rootViewController markItemBadge:[NSString stringWithFormat:@"%d",[UIApplication sharedApplication].applicationIconBadgeNumber]];
    //    }
    //
    //    //清除badge
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //
    //    if([self.window.rootViewController isKindOfClass:[WPMainAppViewController class]])
    //    {
    //
    //    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    //存储用户信息
}

//获取DeviceToken成功
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *realDeviceToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    //[[NSUserDefaults standardUserDefaults] setObject:realDeviceToken forKey:USER_DEFAULTS_SYSTEM_DEVICE_TOKEN];
    
    [[CUFileClient sharedInstance] bindPushToken:realDeviceToken cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData delegate:self selector:@selector(bindPushTokenDone:) selectorError:@selector(bindPushTokenError:)];
    
}

//注册消息推送失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Register Remote Notifications error:{%@}",[error localizedDescription]);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSString *type = [userInfo objectForKey:@"type"];
    
    
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        //点击push通知进入
#warning 根据push通知类型进入不同页面
    }
    
    
}

#pragma mark Request
- (void)bindPushTokenDone:(id)data
{
    //绑定成功
}

- (void)bindPushTokenError:(NSError *)error
{
    //    if (error) {
    //        if ([error.domain isEqualToString:ERROR_DOMAIN]) {
    //            //NSString *reason = [error.userInfo objectForKey:@"reason"];
    //        }else{
    //            //其他错误
    //        }
    //    }
}
@end
