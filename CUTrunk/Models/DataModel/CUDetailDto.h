//
//  CURespond.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataModelBase.h"



@interface CUDetailDto : DataModelBase

@property (nonatomic, copy) NSString *reply_id;
@property (nonatomic, copy) NSString *floor;
@property (nonatomic, copy) NSString *owner_id; //(user_id)
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;
@property (nonatomic, copy) NSString *reply_to_text;
@property (nonatomic, copy) NSString *reply_to_floor;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, assign) BOOL deleteable;
@property (nonatomic, copy) NSString *avatar_image;
@property (nonatomic, copy) NSString *avatar_bg;

@end