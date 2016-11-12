//
//  UITextFieldViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/12.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UITextFieldViewController.h"
#import "JobsConstants.h"

@interface UITextFieldViewController ()
@property(nonatomic, strong) UITextField *textField;

-(void)backgroundTap;
@end

@implementation UITextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    // 要在 Hardware -> Keyboard 中设置，才能在模拟器上弹出虚拟键盘
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0,screenSize.width - 20, 50)];
    _textField = textField;
    textField.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setClearButtonMode:UITextFieldViewModeWhileEditing];//显示右侧删除按钮
    textField.placeholder = @"【剩】键盘收起，键盘遮挡";
    //textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeySearch; // 设置返回值样式
    //textField.secureTextEntry=YES;//设置成密码格式
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first"]];
    textField.leftViewMode = UITextFieldViewModeAlways; // 必须设置模式
    textField.leftView = leftView;
    
    textField.borderStyle = UITextBorderStyleRoundedRect;// 设置边框
    
    UIControl *_back = [[UIControl alloc] initWithFrame:self.view.frame];
    _back.backgroundColor = ANDROID_BLUE;
    self.view = _back;
    [(UIControl *)self.view addTarget:self action:@selector(backgroundTap) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:textField];
}

-(void)backgroundTap{
    //动画是执行推上textfield后还原
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 20.0f, self.view.frame.size.width, self.view.frame.size.height);      //还原view
    self.view.frame = rect;
    [UIView commitAnimations];
    [_textField resignFirstResponder];
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
