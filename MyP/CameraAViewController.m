//
//  CameraViewController.m
//  MyP
//
//  Created by 李全民 on 16/11/17.
//  Copyright © 2016年 李全民. All rights reserved.
//

#import "CameraAViewController.h"
#import "JobsConstants.h"
#import "Masonry.h"

@interface CameraAViewController ()
@property (nonatomic, strong) UIImageView *imageView;

-(void)chooseImage:(id)sender;
-(void)openAlbum;
-(void)openCamera;
@end

@implementation CameraAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:ANDROID_BLUE];
    
    UIButton *photoButton = [[UIButton alloc] init];
    [photoButton setBackgroundColor:[UIColor blackColor]];
    [photoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [photoButton setTitle:@"选择照片" forState:UIControlStateNormal];
    [photoButton setTitleColor:[UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [photoButton addTarget:self action:@selector(chooseImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    
    [photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.mas_width);
        make.top.mas_equalTo(self.view.mas_top).offset(80);
        make.height.mas_equalTo(40);
    }];
    
    self.imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(3);
        make.top.mas_equalTo(photoButton.mas_bottom).offset(10);
        make.right.mas_equalTo(self.view.mas_right).offset(-3);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-3);
    }];
    
    // TODO 写一个相册应用
    /**
     1)如何压缩图片；
     2)如何优化内存；
     3)如何图片多选；
     */
}

-(void)chooseImage:(id)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择" message:@"选取照片" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Sheet-取消");
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAlbum];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [alertController addAction:albumAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 需要在 info.plist 中配置两个Privacy
-(void)openAlbum{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        return;
    
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

-(void)openCamera{
    
}

// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 设置图片
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
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
