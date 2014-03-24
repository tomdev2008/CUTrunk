//
//  CURespond.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUDetailDto.h"

@implementation CUDetailDto
@synthesize reply_id = _reply_id;
@synthesize floor = _floor;
@synthesize owner_id = _owner_id;
@synthesize text = _text;
@synthesize image_url = _image_url;
@synthesize city = _city;
@synthesize longitude = _longitude;
@synthesize latitude = _latitude;
@synthesize reply_to_text = _reply_to_text;
@synthesize reply_to_floor = _reply_to_floor;
@synthesize create_time = _create_time;
@synthesize deleteable = _deleteable;
@synthesize avatar_image = _avatar_image;
@synthesize avatar_bg = _avatar_bg;

- (BOOL)parse2:(NSDictionary *)result
{
    self.reply_id = [self getStrValue:[result objectForKey:@"id"]];
    self.floor = [self getStrValue:[result objectForKey:@"floor"]];
    self.owner_id = [self getStrValue:[result objectForKey:@"owner_id"]];
    self.text = [self getStrValue:[result objectForKey:@"text"]];
    self.image_url = [self getStrValue:[result objectForKey:@"image_url"]];
    self.reply_to_text = [self getStrValue:[result objectForKey:@"reply_to_text"]];
    self.create_time = [self getStrValue:[result objectForKey:@"create_time"]];
    self.deleteable = [self getBoolValue:[result objectForKey:@"deleteable"]];
    self.avatar_image = [self getStrValue:[result objectForKey:@"avatar_image"]];
    self.avatar_bg = [self getStrValue:[result objectForKey:@"avatar_bg"]];
    
    self.city = [self getStrValue:[result objectForKey:@"city"]];
    
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
