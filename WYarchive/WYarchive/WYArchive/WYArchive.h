//
//  WYArchive.h
//  WYarchive
//
//  Created by 王寅 on 16/11/1.
//  Copyright © 2016年 王寅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+WYArchive.h"

@interface WYArchive : NSObject


/**
 存储对象到指定文件

 @param filename 文件名
 @return 是否成功
 */
- (BOOL)saveToFile:(NSString *)filename;
+ (id)loadObjectWithFilename:(NSString *)filename;

@end
