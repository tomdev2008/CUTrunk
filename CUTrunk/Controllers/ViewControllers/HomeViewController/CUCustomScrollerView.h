//
//  CUCustomScrollerView.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ TouchScroller)(BOOL touch);

@interface CUCustomScrollerView : UIScrollView 
{
@protected
    TouchScroller block_touch;
}

- (id)initWithFrame:(CGRect)frame touchBlock:(TouchScroller)touch;
@end
