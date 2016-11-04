# WYArchive
##what is this
利用runtime，减少归档类的代码量，并封装归档解档方法。可以实现自定义类型的持久化存储，自动归档解档。
##如何使用
将WYArchive拖入到你的工程中，需要归档的类继承WYArchive，不再需要实现encodeWithCoder和initWithCoder方法，省去代码量，更节省时间。

###1.归档一个对象到文件中

	NSString *filename = person.test
	
    Person *person = [Person new];
    person.age = 13;
    person.firstname = @"寅";
    person.lastname = @"王";
    
    if ([person saveToFile:filename]) {
        NSLog(@"归档一个对象到文件%@中成功", filename);
    }else{
        NSLog(@"归档对象到%@失败",filename);
    }
    
###2.归档多个对象
	- (void)archiveObjectsToFile:(NSString *)filePath{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 10; i++) {
        Person *person = [[Person alloc] init];
        person.age = i;
        person.firstname = [[UIFont familyNames] objectAtIndex:i];
        person.lastname = [[UIFont familyNames] objectAtIndexedSubscript:i];
        [array addObject:person];
    }
    
    [array wy_archiveObjectsFormArray:array toFilePath:filePath];
}
###3.解档

	- (void)unarchiveObjectToFile:(NSString *)filename    
{
    id object = [WYArchive loadObjectWithFilename:filename];
    }

**demo中有实现代码。**

##到底有多好用

如果不用runtime进行封装的话

代码量是下面这样的，现在你只需要继承就好了。

```
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {
        self.key = [[aDecoder decodeObjectForKey:@"key"] copy];
        self.name = [[aDecoder decodeObjectForKey:@"name"] copy];
        self.password = [[aDecoder decodeObjectForKey:@"password"] copy];
        self.kid = [[aDecoder decodeObjectForKey:@"kid"] copy];
        self.status = [[aDecoder decodeObjectForKey:@"status"] copy];
        self.label = [[aDecoder decodeObjectForKey:@"label"] copy];
        self.owner = [[aDecoder decodeObjectForKey:@"owner"] copy];
        self.phone = [[aDecoder decodeObjectForKey:@"phone"] copy];
        self.community = [[aDecoder decodeObjectForKey:@"community"] copy];
        self.door = [[aDecoder decodeObjectForKey:@"door"] copy];
        self.communityID = [[aDecoder decodeObjectForKey:@"communityID"] copy];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.kid forKey:@"kid"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.label forKey:@"label"];
    [aCoder encodeObject:self.owner forKey:@"owner"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.community forKey:@"community"];
    [aCoder encodeObject:self.door forKey:@"door"];
    [aCoder encodeObject:self.communityID forKey:@"communityID"];
}

```