//
//  FileUtil.h
//  CUTrunk
//
//  Created by yong wang on 14-3-24.
//  Copyright (c) 2014年 CU-App. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtil : NSObject

+ (BOOL)isExist:(NSString *)file;
+ (NSString *)getPicPath;
+ (NSString *)getAudioPath;
+ (NSString *)getInquiryAudioPath;
+ (NSString *)getPhotoPath;
+ (NSString *)getMoviePath;
+ (NSString *)getMovieTempPath;
+ (NSString *)getMovieCachePath;
+ (NSString *)getCachePicPath;

+ (NSString *)getFileName:(NSString *)path;
+ (NSString *)getFilePart:(NSString *)name idx:(NSInteger)idx;
+ (NSString *)getFileName:(NSString *)path suffix:(NSString *)suffix;
+ (NSString *)getBasePath;
+ (BOOL)isLocalFile:(NSString *)path;
+ (BOOL)clearDir:(NSString *)path;
+ (BOOL)clearFile:(NSString *)path;
+ (void)createDir:(NSString *)dirPath;

+ (void)clearCache;
@end
