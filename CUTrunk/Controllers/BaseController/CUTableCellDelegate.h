//
//  CUTableCellDelegate.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

@protocol CUTableCellDelegate <NSObject>

+ (CGFloat)rowHeightForObject:(id)item;

@optional
- (void)setObject:(id)item;
- (void)loadCacheInfo:(id)info;
- (void)clearCacheInfo:(id)info;
@end
