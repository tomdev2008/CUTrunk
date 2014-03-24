//
//  CUTableApiViewController.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUModelApiViewController.h"
#import "EGORefreshTableFooterView.h"
#import "EGORefreshTableHeaderView.h"
#import "CUBaseTableView.h"

@interface CUTableApiViewController : CUModelApiViewController <UITableViewDelegate, UITableViewDataSource,EGORefreshTableHeaderDelegate, EGORefreshTableFooterViewDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    EGORefreshTableFooterView *_refreshFooterView;
    
    BOOL _headerLoading;
    BOOL _footerLoading;
    BOOL _reloading;
}

@property (nonatomic, retain) CUBaseTableView *tableView;
@property (nonatomic, retain) UIImageView *errorImageView;
@property (nonatomic, retain) UILabel *errorLabel;
@property (nonatomic, retain) UILabel *errorDescriptionLabel;
@property (nonatomic, retain) UIView *errorView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
//@property (nonatomic, retain)  MJRefreshHeaderView *refreshHeaderView;
//@property (nonatomic, retain)  MJRefreshFooterView *refreshFooterView;
@property (nonatomic, assign) BOOL enableHeader;
@property (nonatomic, assign) BOOL enableFooter;

- (void)createErrorView;

- (Class)cellClass;
- (void)setSeparatorClear;


- (void)didFinishLoad:(id)array;
- (void)didFailWithError:(int)type;
- (void)activityIndicatorAnimal:(BOOL)animal;

- (int)getTableViewHeaderHeight;
//OVERRIDE
- (UITableView*)getTableView;
- (void)showDataLoading:(CGFloat)offsety;
- (void)activeRefresh;
- (void)reloadHeaderTableViewDataSource;
- (void)reloadFooterTableViewDataSource;
- (void)finishLoadHeaderTableViewDataSource;
- (void)finishLoadFooterTableViewDataSource;
@end


@protocol RefreshTableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@optional

- (void)loadHeader;
- (void)loadFooter;
@end





