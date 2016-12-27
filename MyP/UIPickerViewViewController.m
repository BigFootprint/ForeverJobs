//
//  UIPickerViewViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/25.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "UIPickerViewViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface UIPickerViewViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSArray *yearArr, *monthArr;
@property (nonatomic) int screenWidth;
@end

@implementation UIPickerViewViewController
@synthesize yearArr;
@synthesize monthArr;
@synthesize screenWidth;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    yearArr = @[@"2010", @"2011", @"2012", @"2013"];
    monthArr = @[@"1月", @"2月", @"3月", @"3月"];
    
    screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, screenWidth / 3.0 * 2, 200)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0)
        return [yearArr count];
    return [monthArr count];
}

// returns width of column and height of row for each component.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return screenWidth / 3.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component __TVOS_PROHIBITED{
    return 40;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{
    if(component == 0)
        return @"年份";
    
    return @"月份";
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED{
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"test"];
    return str;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view __TVOS_PROHIBITED{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, screenWidth/3.0f, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    if(component == 0){
        label.text = yearArr[row];
    }else{
        label.text = monthArr[row];
    }
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    if(component == 0){
        NSLog(@"%@", yearArr[row]);
    }else{
        NSLog(@"%@", monthArr[row]);
    }
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
