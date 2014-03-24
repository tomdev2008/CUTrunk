//
//  CUPersonalViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUPersonalViewController.h"
#import "CUSettingViewController.h"

@interface CUPersonalViewController ()

@end

@implementation CUPersonalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"我的", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    __weak CUPersonalViewController *block_self = self;
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        NSString *reuseIdentifier = @"user_info";
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
            staticContentCell.cellHeight = 100;
			[cell.textLabel setText: NSLocalizedString(@"离校名", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.detailTextLabel setText: NSLocalizedString(@"hhahahah", nil)];
            [cell.detailTextLabel setBackgroundColor:[UIColor clearColor]];
            [cell.imageView setImage:[UIImage imageNamed:@"back"]];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
		}];
    }];
    
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        NSString *reuseIdentifier = @"user_info";
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"我的收藏", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
		} whenSelected:^(NSIndexPath *indexPath) {
			//TODO
           
		}];
            
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
            [cell.textLabel setText: NSLocalizedString(@"设置", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
        } whenSelected:^(NSIndexPath *indexPath) {
            //TODO
            [block_self.navigationController pushViewController:[CUSettingViewController shareInstance] animated:YES];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
