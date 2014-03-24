//
//  HNLiveCell.m
//  HNDiscuz
//
//  Created by wang yong on 14-3-21.
//  Copyright (c) 2014年 HNDiscuz. All rights reserved.
//

#import "CULiveCell.h"

@implementation CULiveCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setObject:(id)item
{
    if(item && [item isKindOfClass:[NSDictionary class]])
    {
        [self.imageView setImage:[UIImage imageNamed:[item objectForKey:@"image"]]];
        [self.textLabel setText:[item objectForKey:@"text"]];
        [self.detailTextLabel setText:@"FDAFASFAF"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

+ (CGFloat)rowHeightForObject:(id)item
{
    return 44.0;
}

@end
