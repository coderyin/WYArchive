//
//  NSArray+WYArchive.m
//  WYarchive
//
//  Created by 王寅 on 16/11/2.
//  Copyright © 2016年 王寅. All rights reserved.
//

#import "NSArray+WYArchive.h"

@implementation NSArray (WYArchive)

- (BOOL)wy_archiveObjectsFormArray:(NSArray *)array toFilePath:(NSString *)filename{
    if (!array) {
        return NO;
    }
    if (!filename || filename.length == 0) {
        return NO;
    }
    return [NSKeyedArchiver archiveRootObject:array toFile:[[self class] filePath:filename]];
}

- (NSArray *)wy_arryUnarchiveObjectWithFile:(NSString *)filename{
    if (!filename || filename.length == 0) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
}
+ (NSString *)filePath:(NSString *)filename{
    
    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [paths stringByAppendingString:filename];
    return filePath;
}

@end
