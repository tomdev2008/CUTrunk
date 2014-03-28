//
//  CULoginViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CULoginViewController.h"
#import "CUFileClient.h"
#import "CUAppDelegate.h"
#import "SBJson.h"
#import "CUUserInfoDto.h"
#import <AdSupport/AdSupport.h>

@interface CULoginViewController ()

@end

@implementation CULoginViewController
@synthesize tencentOAuth = _tencentOAuth;

+ (instancetype)shareInstance
{
    static CULoginViewController *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setFrame:self.view.frame];
    [imageView setUserInteractionEnabled:YES];
    [self.view addSubview:imageView];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setWidth:200];
    [loginButton setHeight:40];
    [loginButton setCenter: self.view.center];
    [loginButton setBackgroundColor:[UIColor redColor]];
    [loginButton setTitle:@"login" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:loginButton];
    
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"101023639" andDelegate:self];

    
}

- (void)loginButtonClicked:(id)sender
{   
    [SVProgressHUD showWithStatus:@"登录中..."];
    NSArray *permissions = [NSArray array];
    //[_tencentOAuth authorize:permissions inSafari:NO];

     [[CUFileClient sharedInstance] loginUserSystem:@"" password:@""  cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
}

#pragma -mark TencentSessionDelegate
//- (void)tencentDidLogin
//{
//    NSLog(@"登录完成");
//    
//
//    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
//    {
//        // 记录登录用户的OpenID、Token以及过期时间
//         NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
//        
//        [[CUFileClient sharedInstance] loginUserSystem:@"" password:@""  cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData delegate:self selector:@selector(requestDidFinishLoad:) selectorError:@selector(requestError:)];
//    }
//    else
//    {
//        [SVProgressHUD showErrorWithStatus:@"登录失败"];
//        NSLog(@"登录不成功 没有获取accesstoken");
//    }
//}

- (void)requestDidFinishLoad:(id)data
{
    if(data)
    {
        if ([[CUUserInfoDto sharedInstance] parse:data]) {
            [CUUserInfoDto saveUserInfo:[CUUserInfoDto sharedInstance]];
        }
        
//        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:USER_DEFAULTS_LOCAL_SETTING_SHAKE];
//        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:USER_DEFAULTS_LOCAL_SETTING_VOICE];
        
        [[CUAppDelegate shareInstance] loginSucessed];
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        return;
    }
}

- (void)requestError:(NSError*)error
{
    loading = NO;
    
//    if (error) {
//        if ([error.domain isEqualToString:ERROR_DOMAIN]) {
//            NSString *reason = [error.userInfo objectForKey:@"reason"];
//            
//            [SVProgressHUD showErrorWithStatus:reason];
//        }
//    }
    
    //[self didFailWithError:error.code];
    [SVProgressHUD showErrorWithStatus:@"登录失败"];

}
//
//- (void)tencentDidNotLogin:(BOOL)cancelled
//{
//    if (cancelled)
//    {
//        NSLog(@"用户取消登录");
//        [SVProgressHUD dismiss];
//    }
//    else
//    {
//        NSLog(@"登录失败");
//        [self requestError:nil];
//    }
//    
//  
//}
//
//- (void)tencentDidNotNetWork
//{
//    NSLog(@"无网络连接，请设置网络");
//    [SVProgressHUD dismiss];
//
//}

#pragma -mark loginSecessed


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
