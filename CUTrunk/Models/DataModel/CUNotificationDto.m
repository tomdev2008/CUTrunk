//
//  CUNotificationDto.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUNotificationDto.h"


@implementation CUNotificationDto

- (BOOL)parse2:(NSDictionary *)result
{
    if ([[self getStrValue:[result objectForKey:@"type"]] isEqualToString:@"system"]) {
        self.type = NOTIFY_TYPE_SYSTEM;
    }else if ([[self getStrValue:[result objectForKey:@"type"]] isEqualToString:@"reply_del"]){
        self.type = NOTIFY_TYPE_REPLY_DEL;
    }else if ([[self getStrValue:[result objectForKey:@"type"]] isEqualToString:@"HNDiscuz_del"]){
        self.type = NOTIFY_TYPE_HNDiscuz_DEL;
    }else if ([[self getStrValue:[result objectForKey:@"type"]] isEqualToString:@"HNDiscuz_reply"]){
        self.type = NOTIFY_TYPE_HNDiscuz_REPLY;
    }else if ([[self getStrValue:[result objectForKey:@"type"]] isEqualToString:@"HNDiscuz_like"]){
        self.type = NOTIFY_TYPE_HNDiscuz_LIKE;
    }else {
        self.type = NOTIFY_TYPE_UNKNOWEN;
    }
    
    self.notification_id = [self getStrValue:[result objectForKey:@"notification_id"]];
    self.create_time = [self getStrValue:[result objectForKey:@"create_time"]];
    self.isRead = [self getBoolValue:[result objectForKey:@"readed"]];
    
    self.HNDiscuz_id = [self getStrValue:[result objectForKey:@"HNDiscuz_id"]];
    self.HNDiscuz_text = [self getStrValue:[result objectForKey:@"HNDiscuz_text"]];
    self.HNDiscuz_image = [self getStrValue:[result objectForKey:@"HNDiscuz_image"]];
    
    self.reply_id = [self getStrValue:[result objectForKey:@"reply_id"]];
    self.reply_owner_id = [self getStrValue:[result objectForKey:@"reply_owner_id"]];
    
    self.reply_image = [self getStrValue:[result objectForKey:@"reply_image"]];
    
    self.reply_to_text = [self getStrValue:[result objectForKey:@"reply_to_text"]];
    
    switch (self.type) {
        case NOTIFY_TYPE_SYSTEM:
        case NOTIFY_TYPE_REPLY_DEL:
        case NOTIFY_TYPE_HNDiscuz_DEL:
        {
            NSString *t_user = [self getStrValue:[result objectForKey:@"sys_user"]];
            NSString *t_message = [self getStrValue:[result objectForKey:@"sys_message"]];
            self.message_text = [NSString stringWithFormat:@"%@",t_message];
            self.HNDiscuz_text = t_user;
        }
            break;
            
        case NOTIFY_TYPE_HNDiscuz_LIKE:
        {
            NSString *HNDiscuz_like_count = [self getStrValue:[result objectForKey:@"HNDiscuz_like_count"]];
            
            self.message_text = [NSString stringWithFormat:@"收到1颗红心，累计%@颗",HNDiscuz_like_count];
        }
            break;
            
        case NOTIFY_TYPE_HNDiscuz_REPLY:
        {
            NSString *reply_floor = [self getStrValue:[result objectForKey:@"reply_floor"]];
            NSString *reply_text= [self getStrValue:[result objectForKey:@"reply_text"]];
            
            self.message_text = [NSString stringWithFormat:@"%@楼：%@",reply_floor,reply_text];
        }
            break;
            
        default:
            
            break;
    }
    
    return YES;
}

- (BOOL)parse:(NSDictionary *)dict
{
    BOOL tf = YES;
    //
    error = [[dict objectForKey:@"error"] copy];
    NSDictionary *result = [dict objectForKey:@"data"];
    if (error && [error intValue] == 0 && (NSObject *)result != [NSNull null] && result != nil) {
        [self parse2:result];
    } else {
        tf = NO;
    }
    //
    return tf;
}

@end
