//
//  NSArray+WYArchive.h
//  WYarchive
//
//  Created by 王寅 on 16/11/2.
//  Copyright © 2016年 王寅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WYArchive)


/**
 归档存储一个数组

 @param array 数组
 @param filename 文件名
 @return success
 */
- (BOOL)wy_archiveObjectsFormArray:(NSArray *)array toFilePath:(NSString *)filename;

/**
 解档一个数组

 @param filename 文件名
 @return 解档的数组
 */
- (NSArray *)wy_arryUnarchiveObjectWithFile:(NSString *)filename;

@end
