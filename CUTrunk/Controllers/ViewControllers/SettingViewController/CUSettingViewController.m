//
//  CUSettingViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUSettingViewController.h"
#import "CUAppDelegate.h"
#import "SVWebViewController.h"
#import "FileUtil.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CUFileClient.h"

@interface CUSettingViewController ()

@end

@implementation CUSettingViewController

+ (instancetype)shareInstance
{
    static CUSettingViewController *instance = nil;
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
        self.title = NSLocalizedString(@"设置", nil);
        self.hidesBottomBarWhenPushed = YES;
        
    }
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}

- (NSString*)getPlist
{
    NSString *filePath = [FileUtil getBasePath];
    NSString *plistPath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_setting.plist", @"1111"]];
    return plistPath;
}

- (void)createPlist
{
    NSString *plistPath = [self getPlist];
    
    if(![FileUtil isExist:plistPath])
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
        NSDictionary *account = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"password", nil];
        NSDictionary *push = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"respond", @"1", @"identify", @"0", @"HNDiscuz", nil];
        NSDictionary *system = [NSDictionary dictionaryWithObjectsAndKeys:@"1", @"voice",@"1", @"shark", nil];
        
        NSMutableDictionary *setDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:account, @"account", push, @"push", system, @"system", nil];
        [setDict writeToFile:plistPath atomically:YES];
    }
    
}

- (void)initTableView
{
    NSString *plistPath = [self getPlist];
    
    if(![FileUtil isExist:plistPath])
    {
        [self createPlist];
    }
    
    __weak CUSettingViewController *block_self = self;
	[self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
//        section.title = NSLocalizedString(@"程序内消息", nil);
        NSString *reuseIdentifier = @"system";
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"清空缓存", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
			cell.selectionStyle = UITableViewCellStyleDefault;
			cell.textLabel.text = NSLocalizedString(@"仅WIFI下下载图片", nil);
            
            UISwitch *down_switch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
//            [down_switch setTintColor:[UIColor skyBlueColor]];
//            [down_switch setOnTintColor:[UIColor skyBlueColor]];
            
//            BOOL voice = [[[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_LOCAL_SETTING_VOICE] boolValue];
//            [down_switch setOn:voice animated: NO];
//            [down_switch addTarget:block_self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//			cell.accessoryView = down_switch;
           
		} whenSelected:^(NSIndexPath *indexPath) {
			
		}];
        
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
            [cell.textLabel setText: NSLocalizedString(@"评价我们", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        } whenSelected:^(NSIndexPath *indexPath) {
            SKStoreProductViewController *appStore = [[SKStoreProductViewController alloc] init];
            appStore.delegate = block_self;
            [appStore loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"839545774"} completionBlock:^(BOOL result, NSError *error) {
                if (error) {
                    NSLog(@"%@",error);
                }else{
                    NSLog(@"appstore success");
                }
            }];
            [selected_navigation_controller() presentViewController:appStore animated:YES completion:nil];
            appStore = nil;
            
        }];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"把妹测试", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"意见反馈", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"关于坏男孩", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
       
    }];
    
    
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
		[section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
            cell.accessoryType = UITableViewCellAccessoryNone;
			cell.textLabel.text = NSLocalizedString(@"退出登录", nil);
            //cell.textLabel.textColor = [UIColor watermelonColor];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
		} whenSelected:^(NSIndexPath *indexPath) {
            UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:@"确认退出?"
                                       message:nil
                                      delegate:block_self
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@"确认", nil];
            logoutAlert.tag = 1024;
            [logoutAlert show];
		}];
    }];
    
}

#pragma mark -  appstoreVC  delegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
   
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1024) {
        if (buttonIndex == 1) {
            //do logout
            [[CUFileClient sharedInstance] logoutByUserTicket:NSURLRequestUseProtocolCachePolicy
                                                        delegate:self
                                                        selector:@selector(logoutDone:)
                                                   selectorError:@selector(logoutError:)];
            [SVProgressHUD showWithStatus:@"正在退出..."];
        }
    }
}


- (void)logoutDone:(id)data
{
    [SVProgressHUD dismiss];
//    [WPUserInfoDto cleanAccountDTO];
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:AgainLoginNotification object:nil];
}

- (void)logoutError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"退出失败，请稍后重试"];
}

@end



