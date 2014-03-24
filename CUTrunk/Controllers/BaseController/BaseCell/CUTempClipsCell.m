//
//  CUTempClipsCell.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUTempClipsCell.h"
#import "CUTempClipView.h"

@implementation CUTempClipsCell
@synthesize clipView = _clipView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipView = [[CUTempClipView alloc] initWithFrame:CGRectMake(10, 10, 300, 260)];
        [self.contentView addSubview:_clipView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setObject:(id)item
{
    if(_clipView)
    {
        [_clipView setObject:item];
    }
}

+ (CGFloat)rowHeightForObject:(id)item
{
    return 280;//[HNTempClipView rowHeightForObject:item];
}
@end
