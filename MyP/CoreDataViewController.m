//
//  CoreDataViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/21.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "CoreDataViewController.h"
#import "Masonry.h"
#import "JobsConstants.h"
#import <CoreData/CoreData.h>
#import "Teacher+CoreDataClass.h"
#import "Teacher+CoreDataProperties.h"

@interface CoreDataViewController (){
    NSManagedObjectContext *_context;
}
-(void)establishCoreData;
-(void)startSaveAndSelect:(id)button;

// 数据库操作
-(void)insertCoreData;
-(void)selectCoreData;
-(void)deleteCoreData;
-(void)updateCoreData;
@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];

    UIButton *coredataButton = [[UIButton alloc] init];
    [coredataButton setBackgroundColor:[UIColor blackColor]];
    [coredataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [coredataButton setTitle:@"存取数据" forState:UIControlStateNormal];
    [coredataButton setTitleColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [coredataButton addTarget:self action:@selector(startSaveAndSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:coredataButton];
    
    [coredataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(40);
    }];
    
    [self establishCoreData];
}

-(void)startSaveAndSelect:(id)button{
    [self insertCoreData];
    [self updateCoreData];
    [self selectCoreData];
    [self deleteCoreData];
}

-(void)insertCoreData{
    Teacher *newTeacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:_context];
    
    newTeacher.name = @"AAA";
    newTeacher.age = 12;
    
    NSError *error;
    if(![_context save:&error]){
        NSLog(@"保存失败 : %@", [error localizedDescription]);
    }
}

-(void)selectCoreData{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setFetchLimit:10];
    [fetchRequest setFetchOffset:0];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:_context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [_context executeFetchRequest:fetchRequest error: &error];
    
    for (Teacher *teacher in fetchedObjects) {
        NSLog(@"name : %@", teacher.name);
    }
}

-(void)deleteCoreData{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:_context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:entity];
    NSError *error = nil;
    NSArray *datas = [_context executeFetchRequest:request error:&error];
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas)
        {
            [_context deleteObject:obj];
        }
        if (![_context save:&error])
        {
            NSLog(@"删除失败 : %@", [error localizedDescription]);
        }
    }
}

-(void)updateCoreData{
//    NSPredicate *predicate = [NSPredicate
//                              predicateWithFormat:@"newsid like[cd] %@",newsId];
    
    //首先你需要建立一个request
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:_context]];
    //这里相当于sqlite中的查询条件，具体格式参考苹果文档:https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
//    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *result = [_context executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
    for (Teacher *teacher in result) {
        teacher.name = @"BBB";
    }
    
    //保存
    if (![_context save:&error]) {
        //更新成功
        NSLog(@"更新失败 : %@", [error localizedDescription]);
    }
}

-(void)establishCoreData{
    
    // 获取模型路径
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"School" withExtension:@"momd"];
    
    // 根据模型文件创建模型对象
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // 创建持久化助理
    // 理由模型对象创建助理对象
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 数据库的名称和路径
    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coredata_test.sqlite"];
    
    NSLog(@"path = %@", sqlPath);
    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    // 设置数据库相关信息
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:nil];
    
    // 创建上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _context = context;
    
    //关联持久化助理
    [context setPersistentStoreCoordinator:store];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
