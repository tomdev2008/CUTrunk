//
//  CURecommendViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CURecommendViewController.h"
#import "CUTempClipsCell.h"

@interface CURecommendViewController ()

@end

@implementation CURecommendViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (API_GET_TYPE)modelApi
{
    return API_HOME_LIST;
}

- (Class)cellClass
{
    return [CUTempClipsCell class];
}

@end
