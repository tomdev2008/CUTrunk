//
//  DataModelBase.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModelBase : NSObject <NSCopying> {
    NSString *error;
}


@property (nonatomic, strong) NSMutableDictionary *dtoResult;

- (id)init:(NSString *)dict;
- (BOOL)parse:(NSDictionary *)dict;
- (BOOL)parse2:(NSDictionary *)result;
- (NSDictionary *)JSON;

- (NSInteger)getIntValue:(NSNumber *)num;
- (float)getFloatValue:(NSNumber *)num;
- (BOOL)getBoolValue:(NSNumber *)num;
- (NSString *)getStrValue:(NSString *)str;
- (NSString *)getError;
- (double)getDoubleValue:(NSNumber *)num;

@end
