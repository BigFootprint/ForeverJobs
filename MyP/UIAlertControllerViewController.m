//
//  UIAlertViewViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/11.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIAlertControllerViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface UIAlertControllerViewController ()
-(void)showAlertDialog;
-(void)showActionSheet;
@end

@implementation UIAlertControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    UIButton *buttonDialog = [[UIButton alloc] init];
    [buttonDialog setBackgroundColor:[UIColor whiteColor]];
    [buttonDialog setTitle:@"Dialog" forState:UIControlStateNormal];
    [buttonDialog setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonDialog addTarget:self action:@selector(showAlertDialog) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonDialog];
    
    UIButton *buttonSheet = [[UIButton alloc] init];
    [buttonSheet setBackgroundColor:[UIColor whiteColor]];
    [buttonSheet setTitle:@"Sheet" forState:UIControlStateNormal];
    [buttonSheet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonSheet addTarget:self action:@selector(showActionSheet) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonSheet];
    
    [buttonDialog mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(buttonSheet.mas_width);
        make.height.mas_equalTo(40);
        make.right.mas_equalTo(buttonSheet.mas_left).offset(-10);
        make.left.mas_equalTo(self.view.mas_left).offset(10);
    }];
    
    [buttonSheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(buttonDialog.mas_width);
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(buttonDialog.mas_right).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
    }];
}

-(void)showAlertDialog{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"标题" message:@"这个是UIAlertController的默认样式" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dialog-取消");
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Dialog-好的");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showActionSheet{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"保存或删除数据" message:@"删除数据将不可恢复" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Sheet-取消");
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Sheet-删除");
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Sheet-保存");
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
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
