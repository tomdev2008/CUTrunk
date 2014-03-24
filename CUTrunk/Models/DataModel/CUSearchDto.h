//
//  CUSearchDto.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import "DataModelBase.h"

@interface CUSearchDto : DataModelBase
@property (nonatomic, copy) NSString *thumbUrl;
@property (nonatomic, copy) NSString *largeTnImageUrl;
@property (nonatomic, copy) NSString *textInfo;

@end
