//
//  ViewController.m
//  WYarchive
//
//  Created by 王寅 on 16/11/1.
//  Copyright © 2016年 王寅. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITextField *filePathTextField;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    _filePathTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 40, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    _filePathTextField.placeholder = @"请输入进行归档/解档的文件名";
    _filePathTextField.borderStyle = UITextBorderStyleBezel;
    [_headerView addSubview:_filePathTextField];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20)
                                              style:UITableViewStylePlain];
    _tableView.tableHeaderView = _headerView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _dataSource = @[@"归档一个person", @"归档一组person", @"解档"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (![self checkUserEnter]) return;

    NSString *filename = _filePathTextField.text;
    switch (indexPath.row) {
        case 0:
            [self archiveObjectToFile:filename];
            break;
        case 1:
            [self archiveObjectsToFile:filename];
            break;
        case 2:
            [self unarchiveObjectToFile:filename];
            break;
            
        default:
            break;
    }
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"examplecell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = _dataSource[indexPath.row];
    }
    
    return cell;
}

#pragma mark - 归档一个对象

- (void)archiveObjectToFile:(NSString *)filePath{
    Person *person = [Person new];
    person.age = 13;
    person.firstname = @"寅";
    person.lastname = @"王";
    
    if ([person saveToFile:filePath]) {
        NSLog(@"归档一个对象到文件%@中成功", filePath);
    }else{
        NSLog(@"归档对象到%@失败",filePath);
    }
}

#pragma mark - 归档多个对象

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

#pragma mark - 解档

- (void)unarchiveObjectToFile:(NSString *)filename{
    
    id object = [WYArchive loadObjectWithFilename:filename];
    
    NSLog(@"解档后的数据 ==> %@", object);
}

#pragma mark - Method

- (BOOL)checkUserEnter{

    if (_filePathTextField.text.length == 0) {
        [self showPromptMessage:@"请输入文件名"];
        return NO;
    }
    return YES;
}


- (void)showPromptMessage:(NSString*)message{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    if(version >= 8.0f)
    {
        UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        }];
        [alerController addAction:ensureAction];
        [self presentViewController:alerController animated:true completion:nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


@end
