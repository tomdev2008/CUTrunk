//
//  UIButton+Addition.m
//  HNDiscuz
//
//  Created by 点兄 on 14-3-8.
//  Copyright (c) 2014年 HNDiscuz. All rights reserved.
//

#import "UIButton+Addition.h"


@implementation UIButton_Vertical

-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = (self.frame.size.height-[self titleLabel].height)/2;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    [self titleLabel].bottom = self.height-1;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


@end