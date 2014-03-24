//
//  CUPostDto.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelBase.h"

@interface CUPostDto : DataModelBase

@property (nonatomic, copy) NSString *post_id;
@property (nonatomic, copy) NSString *floor;
@property (nonatomic, copy) NSString *owner_id; //(user_id)
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *details;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *reply_count;
@property (nonatomic, copy) NSString *favorite_count;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *avatar_image;

@end
