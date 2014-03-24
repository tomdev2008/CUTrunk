//
//  CUPostDto.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUPostDto.h"

@implementation CUPostDto
@synthesize post_id = _post_id;
@synthesize floor = _floor;
@synthesize owner_id = _owner_id; //(user_id)
@synthesize title = _title;
@synthesize details = _details;
@synthesize image_url = _image_url;
@synthesize reply_count = _reply_count;
@synthesize favorite_count = _favorite_count;
@synthesize create_time = _create_time;
@synthesize avatar_image = _avatar_image;


- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (BOOL)parse2:(NSDictionary *)result
{
    BOOL tf = YES;
    self.post_id = [[self getStrValue:[result objectForKey:@"post_id"]] copy];
    self.floor = [[self getStrValue:[result objectForKey:@"floor"]] copy];
    self.owner_id = [[self getStrValue:[result objectForKey:@"post_id"]] copy];
    self.title = [[self getStrValue:[result objectForKey:@"floor"]] copy];
    self.details = [[self getStrValue:[result objectForKey:@"post_id"]] copy];
    self.image_url = [[self getStrValue:[result objectForKey:@"floor"]] copy];
    self.reply_count = [[self getStrValue:[result objectForKey:@"post_id"]] copy];
    self.favorite_count = [[self getStrValue:[result objectForKey:@"floor"]] copy];
    self.create_time = [[self getStrValue:[result objectForKey:@"post_id"]] copy];
    self.avatar_image = [[self getStrValue:[result objectForKey:@"floor"]] copy];
    
    return tf;
}
@end
