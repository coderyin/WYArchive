//
//  WYArchive.m
//  WYarchive
//
//  Created by 王寅 on 16/11/1.
//  Copyright © 2016年 王寅. All rights reserved.
//

#import "WYArchive.h"
#import <objc/runtime.h>

@implementation WYArchive


- (void)encodeWithCoder:(NSCoder *)encoder{
    //归档存储自定义对象
    unsigned int count = 0;
    //获得指向该类所有属性的指针
    objc_property_t *properties =     class_copyPropertyList([self class], &count);
    for (int i =0; i < count; i ++) {
        //获得
        objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString   stringWithUTF8String:name];
        //      编码每个属性,利用kVC取出每个属性对应的数值
        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
    }
}

- (instancetype)initWithCoder:(NSCoder *)decoder{
    //归档存储自定义对象
    unsigned int count = 0;
    //获得指向该类所有属性的指针
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i =0; i < count; i ++) {
        objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];        //解码每个属性,利用kVC取出每个属性对应的数值
        [self setValue:[decoder decodeObjectForKey:key] forKeyPath:key];
    }
    return self;
}

+ (NSString *)filePath:(NSString *)filename{

    NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [paths stringByAppendingString:filename];
    return filePath;
}

- (BOOL)saveToFile:(NSString *)filename{
    if (filename.length == 0) return NO;
    return [NSKeyedArchiver archiveRootObject:self toFile:[[self class] filePath:filename]];
}

+ (id)loadObjectWithFilename:(NSString *)filename{
    if (filename.length == 0) return NULL;
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[self class] filePath:filename]];
}

@end
