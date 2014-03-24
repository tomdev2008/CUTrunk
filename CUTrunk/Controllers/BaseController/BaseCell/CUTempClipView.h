//
//  CUTempClipView.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUPostDto.h"

@interface CUTempClipView : UIView

@property(nonatomic, retain) UILabel *textLabel;
@property(nonatomic, retain) UILabel *detailsLabel;
@property(nonatomic, retain) UILabel *nameLabel;
@property(nonatomic, retain) UILabel *timeLabel;
@property(nonatomic, retain) UIButton *commentButton;
@property(nonatomic, retain) UIButton *likeButton;
@property(nonatomic, retain) UIImageView *imageView;
@property(nonatomic, retain) UIImageView *imageViewBackground;
@property(nonatomic, retain) CUPostDto *postDto;


- (void)setObject:(id)item;

- (void)createSubview;
@end
