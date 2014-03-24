//
//  CUNotificationDto.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "DataModelBase.h"

typedef enum
{
    NOTIFY_TYPE_SYSTEM = 0,
    NOTIFY_TYPE_REPLY_DEL,
    NOTIFY_TYPE_HNDiscuz_DEL,
    NOTIFY_TYPE_HNDiscuz_REPLY,
    NOTIFY_TYPE_HNDiscuz_LIKE,
    
    NOTIFY_TYPE_UNKNOWEN,
}NOTIFY_TYPE;

@interface CUNotificationDto : DataModelBase

@property (nonatomic, assign) NOTIFY_TYPE type;
@property (nonatomic, copy) NSString *notification_id;
@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, copy) NSString *message_text;
@property (nonatomic, copy) NSString *detail_text;

@property (nonatomic, copy) NSString *HNDiscuz_id;
@property (nonatomic, copy) NSString *HNDiscuz_text;
@property (nonatomic, copy) NSString *HNDiscuz_image;

@property (nonatomic, copy) NSString *reply_id;
@property (nonatomic, copy) NSString *reply_owner_id;

@property (nonatomic, copy) NSString *reply_image;
@property (nonatomic, copy) NSString *reply_to_text;

@property (nonatomic, copy) NSString *HNDiscuz_like_count;

@property (nonatomic, assign) BOOL isRead;



@end
