//
//  CUFindViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUFindViewController.h"
#import "SVWebViewController.h"
@interface CUFindViewController ()

@end

@implementation CUFindViewController

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
    
    __weak CUFindViewController *block_self = self;
    [self addSection:^(JMStaticContentTableViewSection *section, NSUInteger sectionIndex) {
        NSString *reuseIdentifier = @"find";
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"同城活动", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.imageView setImage:[UIImage imageNamed:@"blueArrow"]];
		} whenSelected:^(NSIndexPath *indexPath) {
            SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:[NSURL URLWithString:@"www.baidu.com"]];
			[block_self.navigationController pushViewController:webViewController animated:YES];
		}];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"课程中心", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.imageView setImage:[UIImage imageNamed:@"back.png"]];

		} whenSelected:^(NSIndexPath *indexPath) {
			
		}];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
			[cell.textLabel setText: NSLocalizedString(@"时尚装备", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.imageView setImage:[UIImage imageNamed:@"back.png"]];

		} whenSelected:^(NSIndexPath *indexPath) {
			
		}];
        
        [section addCell:^(JMStaticContentTableViewCell *staticContentCell, UITableViewCell *cell, NSIndexPath *indexPath) {
            staticContentCell.reuseIdentifier = reuseIdentifier;
            staticContentCell.cellStyle = UITableViewCellStyleDefault;
            [cell.textLabel setText: NSLocalizedString(@"新手入门", nil)];
            [cell.textLabel setBackgroundColor:[UIColor clearColor]];
            [cell.imageView setImage:[UIImage imageNamed:@"back.png"]];

        } whenSelected:^(NSIndexPath *indexPath) {
            //TODO
        }];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
