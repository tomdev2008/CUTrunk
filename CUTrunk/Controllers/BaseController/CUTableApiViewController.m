//
//  CUTableApiViewController.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUTableApiViewController.h"
#import "CUTableCellDelegate.h"
#import "CUFileClient.h"
#import "MobClick.h"
#import "CUTempClipsCell.h"


#define IOS7 (__IPHONE_OS_VERSION_MIN_REQUIRED >= 70000)

@implementation CUTableApiViewController

@synthesize tableView = _tableView;
@synthesize errorImageView = _errorImageView;
@synthesize errorLabel = _errorLabel;
@synthesize errorDescriptionLabel = _errorDescriptionLabel;
@synthesize errorView = _errorView;
@synthesize activityIndicator = _activityIndicator;
@synthesize enableFooter = _enableFooter;
@synthesize enableHeader = _enableHeader;


- (Class)cellClass {
    NSAssert(NO, @"subclasses to override");
    return NULL;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)didFailWithError:(int)type
{
    
    if(_activityIndicator)
    {
        [self activityIndicatorAnimal:NO];
    }
    
    if(_footerLoading)
    {
        [self finishLoadFooterTableViewDataSource];
    }
    
    if(_headerLoading)
    {
        [self finishLoadHeaderTableViewDataSource];
    }
    
    [self setEnableFooter:NO];

    
    [_errorView removeFromSuperview];

    NSString *strFailText = @"网络异常，请稍后重试";
    if([[CUFileClient sharedInstance] getNetworkingType] == 0)
    {
        strFailText = @"当前没有连接到网络";
    }
    else if(-1001 == type)
    {
        strFailText = @"连接超时，请稍后重试";
    }
    
    if(self.model && [(NSArray*)self.model count] > 0)
    {
        [SVProgressHUD showErrorWithStatus:strFailText];
    }
    else
    {
        [_errorDescriptionLabel setText:@""];
        [_errorLabel setText:strFailText];
        [_errorImageView setImage:[UIImage imageNamed:@"error_cat_1"]];
        [[self getTableView] addSubview:_errorView];
        [[self getTableView] sendSubviewToBack:_errorView];
    }

}

- (void)didFinishLoad:(id)array {
    
    if(_activityIndicator)
    {
        [self activityIndicatorAnimal:NO];
    }
    
    //if (array != nil)
    {
        [_errorView removeFromSuperview];
    }
    
    if(_footerLoading)
    {
        [self finishLoadFooterTableViewDataSource];
    }
    
    if(_headerLoading)
    {
        self.model = nil;
        [self finishLoadHeaderTableViewDataSource];
    }

    if([(NSArray*)array count] == 0)
    {
        if(self.model == nil)
        {
            [self addSubErrorView];
            [[self getTableView] reloadData];
        }
        [self setEnableFooter:NO];
        return;
    }
    
    if([(NSArray*)array count] < [self getPageSize])
    {
        [self setEnableFooter:NO];
    }
    else
    {
        [self setEnableFooter:YES];
    }
    
    [super didFinishLoad:array];
    [[self getTableView] reloadData];
}

- (void)addSubErrorView
{
//    API_GET_TYPE api_type = [self modelApi];
//    switch (api_type) {
//        case API_SEARCH_IMAGE_LIST:
//            break;
//            
//        case API_HNDiscuz_SQUARE_LIST:
//            [_errorLabel setText:@"暂时没有悄悄话"];
//            break;
//            
//        case API_NOTIFICATION_LIST:
//            [_errorLabel setText:@"没有消息"];
//            [_errorDescriptionLabel setText:@"当别人回应你，或者红心你的悄悄话时，将会收到消息"];
//            [_errorImageView setImage:[UIImage imageNamed:@"error_cat_2"]];
//            break;
//            
//        case API_HNDiscuz_MINE_LIST:
//            [_errorLabel setText:@"没有发布"];
//            [_errorDescriptionLabel setText:@"您发布的悄悄话将会显示在这里"];
//            [_errorImageView setImage:[UIImage imageNamed:@"error_cat_3"]];
//            break;
//
//        case API_HNDiscuz_HEARTED_LIST:
//            [_errorLabel setText:@"没有红心"];
//            [_errorDescriptionLabel setText:@"您标记红心的悄悄话将会显示在这里"];
//            [_errorImageView setImage:[UIImage imageNamed:@"error_cat_4"]];
//            break;
//            
//        case API_REPLY_LIST:
//            [_errorImageView setHidden:YES];
//            [_errorView setCenterY:self.tableView.tableHeaderView.height + (self.tableView.height - self.tableView.tableHeaderView.height)/2];
//            [_errorView setBackgroundColor:[UIColor whiteColor]];
//            [_errorLabel setText:@"暂时还没有回应"];
//            [_errorLabel setCenterY:(_errorView.height - 44)/2];
//            [_errorDescriptionLabel setText:@""];
//            [_errorDescriptionLabel setTop:_errorLabel.bottom + 10];
//            break;
//        case API_HNDiscuz_HOT_LIST:
//            break;
//            
//        case API_HNDiscuz_NEW_LIST:
//            break;
//            
//        case API_ADMIN_REPORTED_USER_LIST:
//            break;
//            
//        case API_ADMIN_REPORTED_HNDiscuz_LIST:
//            break;
//            
//        case API_ADMIN_REPORTED_REPLY_LIST:
//            break;
//            
//        case API_ADMIN_BLOCKED_USER_LIST:
//            break;
//            
//        default:
//            [_errorLabel setText:@"暂时没有数据"];
//            break;
//    }
//   
//    [[self getTableView] addSubview:_errorView];
//    [[self getTableView] sendSubviewToBack:_errorView];
}

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     
    self.tableView = [[CUBaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate         = self;
    _tableView.dataSource       = self;
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor  = [UIColor whiteColor];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin;
    _tableView.contentMode      = UIViewContentModeScaleAspectFill;
    [self.view addSubview:_tableView];
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:self.view.bounds];
    [viewHeader setHeight:[self getTableViewHeaderHeight]];
    self.tableView.tableHeaderView = viewHeader;
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 20, self.view.width, viewHeader.height)];
    _refreshHeaderView.delegate = self;
    [_refreshHeaderView refreshLastUpdatedDate];
    
    UIView *viewFooter = [[UIView alloc] initWithFrame:self.view.bounds];
    viewFooter.height = 86;
    self.tableView.tableFooterView = viewFooter;
    
    _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 48)];
    _refreshFooterView.delegate = self;
    [_refreshFooterView refreshLastUpdatedDate];

    _headerLoading = NO;
    _footerLoading = NO;
    
    
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_activityIndicator setHidesWhenStopped:YES];
    [_activityIndicator setCenter:self.tableView.center];
    [self activityIndicatorAnimal:YES];
    [self.tableView addSubview:_activityIndicator];
    [self createErrorView];
    
    [self setEnableHeader:YES];
    [self setEnableFooter:NO];
    
   
    [self.tableView setContentOffset:CGPointMake(0, 64) animated:YES];
    
}

- (int)getTableViewHeaderHeight
{
    return 64;
}

- (void)createErrorView
{
    self.errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 200)];
    
    self.errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error_cat_1"]];
    [_errorImageView setFrame:CGRectMake(0, 0, 120, 120)];
    _errorImageView.contentMode = UIViewContentModeCenter;
    [_errorImageView setBackgroundColor:[UIColor clearColor]];
    _errorImageView.centerX = self.errorView.width/2;
    _errorImageView.centerY = self.errorView.height/2;
    
    self.errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _errorView.width, 15)];
    [_errorLabel setTop:_errorImageView.bottom + 5];
    [_errorLabel setFont:[UIFont systemFontOfSize:14.]];
    [_errorLabel setTextColor:[UIColor colorWithRed:155./255. green:155./255. blue:155./255. alpha:1.0]];
    [_errorLabel setTextAlignment:NSTextAlignmentCenter];
    [_errorLabel setBackgroundColor:[UIColor clearColor]];
    
    self.errorDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _errorView.width, 15)];
    [_errorDescriptionLabel setTop:_errorLabel.bottom + 2];
    [_errorDescriptionLabel setFont:[UIFont systemFontOfSize:12.]];
    //[_errorDescriptionLabel setTextColor:[UIColor black75PercentColor]];
    [_errorDescriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_errorDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    
    [_errorView addSubview:_errorImageView];
    [_errorView addSubview:_errorLabel];
    [_errorView addSubview:_errorDescriptionLabel];
    [_errorView setBackgroundColor:[self getTableView].backgroundColor];
    [_errorView setCenterY:[self getTableView].centerY-15];
    [_errorView setCenterX:[self getTableView].centerX];
}

- (UITableView*)getTableView
{
    return _tableView;
}
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self getTableView] reloadData];
//    if(!self.model)
//    {
//        _headerLoading = YES;
//    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self activityIndicatorState];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    if(_activityIndicator)
    {
        [self activityIndicatorAnimal:NO];
    }
}

- (void)activityIndicatorAnimal:(BOOL)animal
{
    if(animal)
    {
        [_activityIndicator setCenterY:230];
        [_activityIndicator startAnimating];
    }
    else
    {
        [_activityIndicator stopAnimating];
    }
    
}
- (void)activityIndicatorState
{
    if(_activityIndicator && _errorView &&![_errorView isDescendantOfView:[self getTableView]] && self.model == nil)
    {
        [self activityIndicatorAnimal:YES];
    }
    else if(_activityIndicator)
    {
        [self activityIndicatorAnimal:NO];
    }
}

- (void)setSeparatorClear
{
    [[self getTableView] setSeparatorColor:[UIColor clearColor]];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
    if(self.model== nil)
        return 0;
    if([self.model isKindOfClass:[NSDictionary class]])
        return 1;
    
    return [(NSArray*)self.model count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if([cell isKindOfClass:[HNTempClipsCell class]])
//    {
//        [(HNBaseTableView*)tableView addBehaviorsToCell:cell];
//        [((HNBaseTableView*)tableView) willDisplayCell:cell forRowAtIndexPath:indexPath];
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cls = [self cellClass];
    static NSString *identifier = @"temp";
    if([NSStringFromClass(cls) isEqualToString:@"HNTempClipsCell"])
    {
       identifier = (indexPath.row/2==0)?@"Cell":@"CELL";
    }
    else
    {
        identifier = NSStringFromClass(cls);
    }
    
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[cls alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if ([cell respondsToSelector:@selector(setObject:)]) {
        if([(NSArray*)self.model count] > indexPath.row)
        {
            id item = nil;
            if(self.model != nil && [self.model isKindOfClass:[NSArray class]])
                item = [self.model objectAtIndex:indexPath.row];
            else if(self.model != nil && [self.model isKindOfClass:[NSDictionary class]])
                item = self.model;

            [cell setObject:item];
        }
    }
    
    ((UITableViewCell*)cell).contentView.superview.clipsToBounds = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = nil;
    if(self.model != nil && [self.model isKindOfClass:[NSArray class]])
        item = [self.model objectAtIndex:indexPath.row];
    else if(self.model != nil && [self.model isKindOfClass:[NSDictionary class]])
        item = self.model;
    
    Class cls = [self cellClass];
    if ([cls respondsToSelector:@selector(rowHeightForObject:)]) {
        return [cls rowHeightForObject:item];
    }
    return tableView.rowHeight; // failover
}

#pragma mark -
#pragma mark refreshView Methods
#pragma scro
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)showDataLoading:(CGFloat)offsety
{
    // 会调用loadHeader
    if (_enableHeader == YES && offsety <= -44)
    {
        [self getTableView].contentOffset = CGPointMake(0, offsety);
        [_refreshHeaderView egoRefreshScrollViewDidScroll: [self getTableView]];
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging: [self getTableView]];
    }
}

- (void)activeRefresh
{
    [self showDataLoading: -80];
}

- (void)setEnableFooter:(BOOL)tf
{
    _enableFooter = tf;
    if (tf == YES) {
        [self getTableView].tableFooterView = _refreshFooterView;
    } else {
        UIView *viewFooter = [[UIView alloc] initWithFrame:self.view.bounds];
        viewFooter.height = 46;
        [self getTableView].tableFooterView = viewFooter;
    }
}

- (void)setEnableHeader:(BOOL)tf
{
    _enableHeader = tf;
    if (tf == YES) {
        if ([[self getTableView].tableHeaderView.subviews containsObject:_refreshHeaderView] == NO) {
            [[self getTableView].tableHeaderView addSubview:_refreshHeaderView];
        }
    } else {
        if ([[self getTableView].tableHeaderView.subviews containsObject:_refreshHeaderView] == YES) {
            [_refreshHeaderView removeFromSuperview];
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView.contentOffset.y = %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 0) {
        [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    } else if (scrollView.contentOffset.y > 10) {
        [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGSize size = scrollView.frame.size;
    CGFloat offsety = scrollView.contentOffset.y;
    
    CGFloat offset = scrollView.contentSize.height - size.height;
    if (offset < 0) {
        offset = 0;
    }
    if (_enableHeader == YES && offsety < -50) {
        // header刷新
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    } else if (_enableFooter == YES && offsety > offset+10) {
        // footer刷新
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    //NSLog(@"scrollViewDidEndDragging %f %f",offset, offsety);

}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self reloadHeaderTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _headerLoading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date];
}

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view
{
    [self reloadFooterTableViewDataSource];
}

- (BOOL)egoRefreshTableFooterDataSourceIsLoading:(EGORefreshTableFooterView*)view
{
    return _footerLoading;
}

- (NSDate*)egoRefreshTableFooterDataSourceLastUpdated:(EGORefreshTableFooterView*)view
{
    return [NSDate date];
}

- (void)loadMoreData:(NSNumber *)loadHeader
{
    [super loadMoreData:loadHeader];
}

- (void)reloadHeaderTableViewDataSource
{
    if([_activityIndicator isAnimating])
    {
        [self finishLoadHeaderTableViewDataSource];
        return;
    }
    _headerLoading = YES;
    if ([self respondsToSelector:@selector(loadMoreData:)] == YES) {
        [self performSelector:@selector(loadMoreData:) withObject:[NSNumber numberWithBool:NO]];
    }
}

- (void)reloadFooterTableViewDataSource
{
	_footerLoading = YES;
    if ([self respondsToSelector:@selector(loadMoreData:)] == YES) {
        [self performSelector:@selector(loadMoreData:) withObject:[NSNumber numberWithBool:YES]];
    }
    
}

- (void)finishLoadHeaderTableViewDataSource
{
    [self performSelector:@selector(checkTimeout:) withObject:_refreshHeaderView afterDelay:0.01];
}

- (void)finishLoadFooterTableViewDataSource
{
    [self performSelector:@selector(checkTimeout:) withObject:_refreshFooterView afterDelay:0.01];
}

- (void)checkTimeout:(id)view
{
    if ([view isKindOfClass:[EGORefreshTableHeaderView class]] == YES) {
        _headerLoading = NO;
        
        EGORefreshTableHeaderView *header = (EGORefreshTableHeaderView *)view;
        if ([header getState] != EGOOPullRefreshNormal) {
            [header egoRefreshScrollViewDataSourceDidFinishedLoading:[self getTableView]];
        }
    } else if ([view isKindOfClass:[EGORefreshTableFooterView class]] == YES) {
        _footerLoading = NO;
        EGORefreshTableFooterView *footer = (EGORefreshTableFooterView *)view;
        if ([footer getState] != EGOOPullRefreshNormal) {
            [footer egoRefreshScrollViewDataSourceDidFinishedLoading:[self getTableView]];
        }
    }
}

@end
