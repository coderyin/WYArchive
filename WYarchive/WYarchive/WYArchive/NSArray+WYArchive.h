//
//  NSArray+WYArchive.h
//  WYarchive
//
//  Created by 王寅 on 16/11/2.
//  Copyright © 2016年 王寅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WYArchive)

- (BOOL)wy_archiveObjectsFormArray:(NSArray *)array toFilePath:(NSString *)filename;
- (NSArray *)wy_arryWithFilePath:(NSString *)filename;

@end
