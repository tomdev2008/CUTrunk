//
//  UIImage+Addition.h
//  HNDiscuz
//
//  Created by 点兄 on 14-3-16.
//  Copyright (c) 2014年 HNDiscuz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (Blur)

// 0.0 to 1.0
- (UIImage*)blurredImage:(CGFloat)blurAmount;

@end


@interface UIImage (ImageWithColor)

- (UIImage *)imageWithColor:(UIColor *)color;

@end


@interface UIImage (Screenshot)

+ (UIImage *)screenshot;

@end

@interface UIImage (TransformUIView)

+ (UIImage *)imageWithUIView:(UIView *)view;


@end