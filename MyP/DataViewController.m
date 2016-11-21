//
//  DataViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/13.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "DataViewController.h"
#import "JobsConstants.h"
#import "sqlite3.h"
#import "CoreDataViewController.h"

static NSString *const dataContent = @"我要存储1234567890qwertyuiopasdfghjklzxcvbnm,./l;'[]\\=-!@#$%^&*()_+{}|:\"<>?";

@interface DataEntity : NSObject<NSCoding>
@property (nonatomic, strong) NSString *data;
@end

@implementation DataEntity

-(id)initWithCoder:(NSCoder *)aDecoder{
    if([super init]){
        self.data = [aDecoder decodeObjectForKey:@"data"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.data forKey:@"data"];
}

@end

@interface DataViewController ()

-(NSString *)persistViaNSUserDefaults;
-(NSString *)persistViaPlist;
-(NSString *)persistViaNSKeyArchiver;
-(NSString *)persistViaSQLite;
-(void)persistViaCoreData;

-(void)showAlterView:(NSString *)content;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", NSHomeDirectory());
    
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    int startHeight = 44 + STATUS_BAR_HEIGHT + 5;
    // Label显示读取内容
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, startHeight, screenSize.width - 10, 80)];
    contentLabel.backgroundColor = [UIColor blackColor];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = [UIColor whiteColor];
    contentLabel.text = dataContent;
    
    startHeight += (80 + 5);
    
    // 用于保存偏好信息，
    UIButton *nsUserDefaultsButton = [[UIButton alloc] initWithFrame:CGRectMake(5, startHeight, screenSize.width/2 - 10, 40)];
    [nsUserDefaultsButton setTitle:@"NSUserDefaults" forState:UIControlStateNormal];
    [nsUserDefaultsButton addTarget:self action:@selector(persistViaNSUserDefaults) forControlEvents:UIControlEventTouchUpInside];
    [nsUserDefaultsButton setBackgroundColor:[UIColor orangeColor]];
    [nsUserDefaultsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton *plistButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width/2 + 5, startHeight, screenSize.width/2 - 10, 40)];
    [plistButton setTitle:@"plist" forState:UIControlStateNormal];
    [plistButton addTarget:self action:@selector(persistViaPlist) forControlEvents:UIControlEventTouchUpInside];
    [plistButton setBackgroundColor:[UIColor orangeColor]];
    [plistButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    startHeight += (40 + 5);
    UIButton *SQLiteButton = [[UIButton alloc] initWithFrame:CGRectMake(5, startHeight, screenSize.width/2 - 10, 40)];
    [SQLiteButton setTitle:@"SQLite" forState:UIControlStateNormal];
    [SQLiteButton addTarget:self action:@selector(persistViaSQLite) forControlEvents:UIControlEventTouchUpInside];
    [SQLiteButton setBackgroundColor:[UIColor orangeColor]];
    [SQLiteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIButton *coreDataButton = [[UIButton alloc] initWithFrame:CGRectMake(screenSize.width/2 + 5, startHeight, screenSize.width/2 - 10, 40)];
    [coreDataButton setTitle:@"CoreData" forState:UIControlStateNormal];
    [coreDataButton addTarget:self action:@selector(persistViaCoreData) forControlEvents:UIControlEventTouchUpInside];
    [coreDataButton setBackgroundColor:[UIColor orangeColor]];
    
    startHeight += (40 + 5);
    UIButton *nsKeyedArchiverButton = [[UIButton alloc] initWithFrame:CGRectMake(5, startHeight, screenSize.width/2 - 10, 40)];
    [nsKeyedArchiverButton setTitle:@"NSKeyedArchiver" forState:UIControlStateNormal];
    [nsKeyedArchiverButton addTarget:self action:@selector(persistViaNSKeyArchiver) forControlEvents:UIControlEventTouchUpInside];
    [nsKeyedArchiverButton setBackgroundColor:[UIColor orangeColor]];
    [nsKeyedArchiverButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:contentLabel];
    [self.view addSubview:nsUserDefaultsButton];
    [self.view addSubview:plistButton];
    [self.view addSubview:SQLiteButton];
    [self.view addSubview:coreDataButton];
    [self.view addSubview:nsKeyedArchiverButton];
}

-(void)viewWillAppear:(BOOL)animated{
    self.title = @"Data·学习";
}

/**
 以下这三种方式否是覆盖存储，要想添加数据，就必须将文件内容全部读出，修改后再写入，因此不适合存储大量数据
 */
-(NSString *)persistViaNSUserDefaults{
    // 这种写入会将文件存储到一个特定的plist文件中: 、Library/Preference文件夹下面以该应用包名命名(com.footprint.MyP)的文件
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:dataContent forKey:@"key"];
    [userDefault synchronize];// 调用会理解写入，否则时刻不定
    
    NSString *data = [userDefault objectForKey:@"key"];
    [self showAlterView:data];
    
    return data;
}

-(NSString *)persistViaPlist{
    // 以下基本类型可以写入到 plist 文件
    // NSArray;
    // NSMutableArray;
    // NSDictionary;
    // NSMutableDictionary;
    // NSData;
    // NSMutableData;
    // NSString;
    // NSMutableString;
    // NSNumber;
    // NSDate;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"test.plist"];
    NSLog(@"Plist存储路径：%@", fileName);
    [dataContent writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *data = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    [self showAlterView:data];
    return data;
}

-(NSString *)persistViaNSKeyArchiver{
    // 对象必须实现 NSCoding 协议
    // 继承子类必须调用父类的super方法
    // 很像 Android 的 Parcelable 接口
    DataEntity *dataEntity  = [[DataEntity alloc] init];
    dataEntity.data = dataContent;
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"test.data"];
    [NSKeyedArchiver archiveRootObject:dataEntity toFile:fileName];
    
    DataEntity *readEntity = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    [self showAlterView:readEntity.data];
    return readEntity.data;
}

/**
 大数据存取
 */

// 这篇文章讲述的很详细：http://www.cnblogs.com/QianChia/p/5782861.html
// 需要配置库文件
-(NSString *)persistViaSQLite{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"test.db"];
    
    sqlite3 *db;
    // 创建数据库
    if(sqlite3_open([fileName UTF8String], &db)== SQLITE_OK){
        NSLog(@"SQLite is opened.");
    }else{
        NSLog(@"SQLite open failed.");
    }
    
    // 创建表
    NSString *tableCreateSQL = @"create table if not exists Jobs(id integer primary key autoincrement, content text, seq integer)";
    char *errorMsg;
    if(sqlite3_exec(db, [tableCreateSQL UTF8String], NULL, NULL, &errorMsg) == SQLITE_OK){
        NSLog(@"Create table is OK.");
    }else{
        NSLog(@"Error msg: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
    // 插入数据
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO Jobs ('content', 'seq') VALUES (?, ?)"];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        sqlite3_bind_text(statement, 1, [dataContent UTF8String], -1, NULL);
        sqlite3_bind_text(statement, 2, [@"1" UTF8String], -1,NULL);
    }
    
    if(sqlite3_step(statement) == SQLITE_OK){
        NSLog(@"Insert is OK.");
    }else{
        NSLog(@"Error msg: %s", errorMsg);
        sqlite3_free(errorMsg);
    }
    sqlite3_finalize(statement);
    
    // 读取数据
    NSString *selectSql = @"SELECT id, content, seq from Jobs";
    NSString *content;
    if (sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while(sqlite3_step(statement) == SQLITE_ROW) {
            int _id = sqlite3_column_int(statement, 0);
            char *rawContent = (char *)sqlite3_column_text(statement, 1);
            content = [[NSString alloc] initWithUTF8String:rawContent];
            int seq = sqlite3_column_int(statement, 2);
            NSLog(@"id: %i, content: %@, seq: %i", _id, content, seq);
        }
    } else {
        NSLog(@"select operation is fail.");
    }
    sqlite3_finalize(statement);
    
    // 关闭数据库
    sqlite3_close(db);
    
    [self showAlterView:content];
    return content;
}

-(void)persistViaCoreData{
    CoreDataViewController *coreDataController = [[CoreDataViewController alloc] init];
    [self.navigationController pushViewController:coreDataController animated:YES];
}

-(void)showAlterView:(NSString *)content{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"存储内容" message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
