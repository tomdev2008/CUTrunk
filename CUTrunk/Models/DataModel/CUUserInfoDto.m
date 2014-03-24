//
//  CUUserInfoDto.m
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUUserInfoDto.h"
#import <MapKit/MapKit.h>

@implementation CUUserInfoDto

+ (instancetype)sharedInstance {
    static CUUserInfoDto *instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (BOOL)parse2:(NSDictionary *)result_dict
{
    NSDictionary *result = [result_dict objectForKey:@"user"];
    if(result)
    {
        self.user_id = [self getStrValue:[result objectForKey:@"id"]];
        self.role = [self getStrValue:[result objectForKey:@"role"]];
        self.visit_password = [self getStrValue:[result objectForKey:@"visit_password"]];
        self.push_on_reply = [self getBoolValue:[result objectForKey:@"push_on_reply"]];
        self.push_on_like = [self getBoolValue:[result objectForKey:@"push_on_like"]];
        self.push_nearby_HNDiscuz = [self getBoolValue:[result objectForKey:@"push_nearby_HNDiscuz"]];
        self.reply_limit = [self getIntValue:[result objectForKey:@"reply_limit"]];
        
        if ([result objectForKey:@"longitude"] && [result objectForKey:@"latitude"]) {
            self.longitude = [self getDoubleValue:[result objectForKey:@"longitude"]];
            self.latitude = [self getDoubleValue:[result objectForKey:@"latitude"]];
        }else {
            self.longitude = self.latitude = 250.0;//设置经纬度不合法
        }
        
        self.invite_code = [self getStrValue:[result objectForKey:@"invite_code"]];
        self.invite_count = [self getIntValue:[result objectForKey:@"invite_count"]];
        self.invited = [self getBoolValue:[result objectForKey:@"invited"]];
    }
    
    self.token = [result_dict objectForKey:@"token"];
    self.host = [result_dict objectForKey:@"host"];
    
    return YES;
}

- (BOOL)parse:(NSDictionary *)dict
{
    BOOL tf = YES;
    if (dict && (NSObject *)dict != [NSNull null]) {
        [self parse2:dict];
    } else {
        tf = NO;
    }
    //
    return tf;
}

/*与存储相关*/
- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:_user_id forKey:@"_user_id"];
    [aCoder encodeObject:_role forKey:@"_role"];
    [aCoder encodeObject:_visit_password forKey:@"_visit_password"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",_push_on_reply] forKey:@"_push_on_reply"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",_push_on_like] forKey:@"_push_on_like"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",_push_nearby_HNDiscuz] forKey:@"_push_nearby_HNDiscuz"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",_reply_limit] forKey:@"_reply_limit"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%f",_longitude] forKey:@"_longitude"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%f",_latitude] forKey:@"_latitude"];
    [aCoder encodeObject:_token forKey:@"_token"];
    [aCoder encodeObject:_host forKey:@"_host"];
    
    [aCoder encodeObject:_invite_code forKey:@"invite_code"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",_invite_count] forKey:@"invite_count"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",_invited] forKey:@"invited"];
}

/*与读取相关*/
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.user_id = [aDecoder decodeObjectForKey:@"_user_id"];
        self.role = [aDecoder decodeObjectForKey:@"_role"];
        self.visit_password = [aDecoder decodeObjectForKey:@"_visit_password"];
        self.push_on_reply = [[aDecoder decodeObjectForKey:@"_push_on_reply"] boolValue];
        self.push_on_like = [[aDecoder decodeObjectForKey:@"_push_on_like"] boolValue];
        self.push_nearby_HNDiscuz = [[aDecoder decodeObjectForKey:@"_push_nearby_HNDiscuz"] boolValue];
        self.reply_limit = [[aDecoder decodeObjectForKey:@"_reply_limit"] integerValue];
        self.longitude = [[aDecoder decodeObjectForKey:@"_longitude"] floatValue];
        self.latitude = [[aDecoder decodeObjectForKey:@"_latitude"] floatValue];
        
        self.token = [aDecoder decodeObjectForKey:@"_token"];
        self.host = [aDecoder decodeObjectForKey:@"_host"];
        
        self.invite_code = [aDecoder decodeObjectForKey:@"_invite_code"];
        self.invite_count = [[aDecoder decodeObjectForKey:@"_invite_count"] integerValue];
        self.invited = [[aDecoder decodeObjectForKey:@"_invited"] boolValue];
    }
    
	return self;
}

+ (void)saveUserInfo:(CUUserInfoDto *)loginUserInfo
{
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:loginUserInfo];
    
//    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:USER_DEFAULTS_SYSTEM_USER];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)activeLoginUserInfo
{
    CUUserInfoDto *user = [CUUserInfoDto loginUserInfo];
    
   
   
}

+ (CUUserInfoDto *)loginUserInfo
{
    
//    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULTS_SYSTEM_USER];
//    if (userData) {
//        HNUserInfoDto *user = [[HNUserInfoDto alloc] init];
//        user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//        
//        return user;
//    }
    
    return nil;
}

#pragma mark - Clear Local Data
+ (void)cleanAccountDTO
{
 //   [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_DEFAULTS_SYSTEM_USER];
    
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_DEFAULTS_SYSTEM_TOKEN];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_DEFAULTS_SYSTEM_HOST];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_DEFAULTS_SYSTEM_DEVICE_TOKEN];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
