//
//  CUFileClient.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CURequestSender.h"
#import "CUConfig.h"
#import <MapKit/MapKit.h>


@interface CUFileClient : CUConfig
{
    int nNetworkingType;
}

+ (instancetype)sharedInstance;
- (int)getNetworkingType;

#pragma mark 个人资料
/**
 * API:登录
 *
 * token，腾讯返回的token
 * login_type，登录类型
 */
- (void)loginUserSystem:(NSString*)email password:(NSString*)password cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:用户注册
 *
 * ticket
 */
- (void)registerUserSystem:(NSString*)email password:(NSString*)password username:(NSString*)username description:(NSString*)description cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:退出登录
 *
 * ticket
 */
- (void)logoutByUserTicket:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:获取个人资料
 *
 * user_id，(可选)，不填则是自己
 */
- (void)getUserProfile:(NSString*)user_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:更新个人资料
 *
 * username，            用户名
 * birthday,            生日
 * height,              身高
 * weight,              体重
 * city,                city城市
 * favor_tag,           爱好标签
 * image,               图片墙
 */
- (void)updateUserProfile:(NSString*)username birthday:(NSString*)birthday height:(int)height  weight:(int)weight city:(NSString*)city description:(NSString*)description favorTag:(NSString*)favor_tag image:(NSArray*)image_array pushNearbyHNDiscuz:(NSString*)push_nearby_HNDiscuz cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

#pragma mark 悄悄话
/**
 * API:获取附近的人
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listNearUser:(double)longitude latitude:(double)latitude limit:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:创建悄悄话
 *
 * token,       登录时返回的token
 * text,        文字
 * image,       图片，如果是字符串字段，则认为是远程图片的地址，如果是文件字段，则认为是上传图片
 * city,        可选,城市
 * longitude,   可选,经度
 * latitude,    可选,纬度
 */
- (void)createHNDiscuz:(NSString*)text image:(UIImage*)image cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:获取单个悄悄话
 *
 * token,       登录时返回的token
 * id,          悄悄话id
 */
- (void)getHNDiscuz:(NSString*)HNDiscuz_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:删除悄悄话
 *
 * token,       登录时返回的token
 * id,          悄悄话id
 */
- (void)deleteHNDiscuz:(NSString*)HNDiscuz_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:喜欢悄悄话
 *
 * token,       登录时返回的token
 * id,          悄悄话id
 * like,        0 or 1 是否喜欢
 */
- (void)likeHNDiscuz:(NSString*)HNDiscuz_id like:(NSString*)like cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:举报悄悄话
 *
 * token,       登录时返回的token
 * id,          悄悄话id
 */
- (void)reportHNDiscuz:(NSString*)HNDiscuz_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:广场（所有悄悄话）
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listAllHNDiscuz:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:附近的悄悄话
 *
 * token,       登录时返回的token
 * distance,    距离
 * longitude,   经度
 * latitude,    纬度
 * limit,
 * offset_id,
 */
- (void)listNearbyHNDiscuz:(NSString *)distance limit:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:我的悄悄话列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listMyHNDiscuz:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:喜欢的悄悄话列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listHeartedHNDiscuz:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

#pragma mark 回应
/**
 * API:创建回应
 * token，       登录时返回的token
 * HNDiscuz_id,   被回应的悄悄话ID
 * text,         文字
 * image,        可选,图片，如果是字符串字段，则认为是远程图片的地址，如果是文件字段，则认为是上传图片
 * reply_to_id,  可选，被回复的回应ID
 * city,         可选,城市
 * longitude,    可选,经度
 * latitude,     可选,纬度
 */
- (void)createReply:(NSString*)HNDiscuzID replyID:(NSString*)replyID text:(NSString*)text image:(NSString*)image cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:回应列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listReplyOfHNDiscuz:(NSString*)HNDiscuzID limit:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:删除
 *
 * token,       登录时返回的token
 * id,          回应ID
 */
- (void)deleteReply:(NSString*)reply_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:举报
 *
 * token,       登录时返回的token
 * id,          回应ID
 */
- (void)reportReply:(NSString*)reply_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

#pragma mark 管理员
/**
 * API:热门的悄悄话列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listHotHNDiscuz:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:最新的悄悄话列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listNewHNDiscuz:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**g
 * API:被举报用户列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listReprotedUser:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:被举报悄悄话列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listReprotedHNDiscuz:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:被举报回应列表
 *
 * token,       登录时返回的token
 * limit
 * offset_id
 */
- (void)listReprotedReply:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:封禁/解禁用户
 *
 * token，登录时返回的token
 * user_id, 被封用户的ID
 * blocked, 0 or 1 是否被封禁
 */
- (void)blockUser:(NSString*)user_id blocked:(NSString*)block cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:封禁用户列表
 *
 * token，登录时返回的token
 * limit
 * offset_id
 */
- (void)listBlockedUser:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:创建系统消息
 *
 * token，登录时返回的token
 * message，消息内容
 */
- (void)createSystemMessage:(NSString *)message cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:创建渠道
 *
 * token，登录时返回的token
 * name，渠道名称
 */
- (void)createChannel:(NSString *)channelName cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:渠道列表
 *
 * token，登录时返回的token
 * limit
 * offset_id
 */
- (void)listChannel:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

/**
 * API:接受邀请
 *
 * token，登录时返回的token
 * device_id，设备唯一标示
 * invite_code，邀请码
 */
- (void)acceptInvite:(NSString *)invite_code deviceID:(NSString *)device_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

#pragma mark 其他
/**
 * API:绑定Push通知token
 *
 * token，登录时返回的token
 * push_token, apple 返回的push token
 */
- (void)bindPushToken:(NSString*)push_token cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:通知列表
 *
 * token，登录时返回的token
 * limit
 * offset_id
 */
- (void)listNotification:(int)limit offsetId:(int)offset_id cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;


/**
 * API:获取baidu图片
 *
 *
 * limit
 * offset_id
 */
- (void)listImageFromBaidu:(int)limit offsetId:(int)offset_id text:(NSString*)text cachePolicy:(NSURLRequestCachePolicy)cholicy  delegate:(id)theDelegate selector:(SEL)theSelector selectorError:(SEL)theSelectorError;

@end


