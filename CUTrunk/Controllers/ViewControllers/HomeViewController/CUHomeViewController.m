//
//  CUHomeViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUHomeViewController.h"
#import "UIImage+Addition.h"
#import "CUTempClipsCell.h"
#import "CUCycleScrollView.h"
#import "CURecommendViewController.h"
#import "CULiveCell.h"
#import "SBJson.h"


#define IOS7 (__IPHONE_OS_VERSION_MIN_REQUIRED >= 70000)

@interface CUHomeViewController ()
{
    UISegmentedControl *segmentedControl;
    //HNTableApiViewController *_tempViewController;
}

@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@property (nonatomic, strong) UIButton *distanceBtn;
@property (nonatomic, retain) CUCycleScrollView *tableHeader;
@end



@implementation CUHomeViewController
@synthesize tableHeader = _tableHeader;

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

    self.navigationItem.title = @"";
}

- (int)getTableViewHeaderHeight
{
    return self.tableView.tableHeaderView.height + 260 + 40;
}

- (Class)cellClass
{
    return [CUTempClipsCell class];
}

- (API_GET_TYPE)modelApi
{
    return API_HOME_LIST;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
