//
//  CUTempClipsCell.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUTempClipView.h"
#import "CUTableCellDelegate.h"

@interface CUTempClipsCell : UITableViewCell<CUTableCellDelegate>


@property (nonatomic, retain) CUTempClipView *clipView;
@end
