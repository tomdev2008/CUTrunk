//
//  CUSearchDto.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "CUSearchDto.h"

@implementation CUSearchDto
@synthesize thumbUrl = _thumbUrl;
@synthesize largeTnImageUrl = _largeTnImageUrl;
@synthesize textInfo = _textInfo;

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
    self.thumbUrl = [[self getStrValue:[result objectForKey:@"thumbURL"]] copy];
    self.largeTnImageUrl = [[self getStrValue:[result objectForKey:@"objURL"]] copy];

    return tf;
}

@end
