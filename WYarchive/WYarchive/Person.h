//
//  Person.h
//  WYarchive
//
//  Created by 王寅 on 16/11/1.
//  Copyright © 2016年 王寅. All rights reserved.
//

#import "WYArchive.h"

@interface Person : WYArchive

@property (nonatomic, assign) int age;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *lastname;

@end
