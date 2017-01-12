//
//  UITouchViewController.m
//  MyP
//
//  Created by 李全民 on 17/1/11.
//  Copyright © 2017年 李全民. All rights reserved.
//

#import "UITouchViewController.h"
#import "JobsConstants.h"

@interface UITouchViewController ()
@property(nonatomic, strong) UIButton *button;

-(void)clickBtn:(id)sender;
@end

@implementation UITouchViewController
@synthesize button;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ANDROID_BLUE;
    
    button = [[XYButton alloc] initWithFrame:CGRectMake(0, 80, 200, 200)];
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)clickBtn:(id)sender {
    NSLog(@"Click Done!");
//    [button setNeedsDisplay];
}

@end

@interface XYButton ()
-(void)printTouchInfo:(UITouch *)touch withTag:(NSString *)tag;
@end

@implementation XYButton

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    NSLog(@"drawRect");
}

-(void)layoutSubviews{
    NSLog(@"layoutSubviews");
}

// UIControl
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    [self printTouchInfo:touch withTag:@"UIControl-Begin"];
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    [self printTouchInfo:touch withTag:@"UIControl-Move"];
    return YES;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    [self printTouchInfo:touch withTag:@"UIControl-End"];
}

- (void)cancelTrackingWithEvent:(nullable UIEvent *)event {
    [self printTouchInfo:[[event.allTouches allObjects] objectAtIndex:0] withTag:@"UIControl-End"];
}

// UIResponder
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self printTouchInfo:[[touches allObjects] objectAtIndex:0] withTag:@"UIResponder-Begin"];
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self printTouchInfo:[[touches allObjects] objectAtIndex:0] withTag:@"UIResponder-Move"];
    [super touchesMoved:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self printTouchInfo:[[touches allObjects] objectAtIndex:0] withTag:@"UIResponder-End"];
    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    [self printTouchInfo:[[touches allObjects] objectAtIndex:0] withTag:@"UIResponder-Cancel"];
    [super touchesCancelled:touches withEvent:event];
}

-(void)printTouchInfo:(UITouch *)touch withTag:(NSString *)tag {
    CGPoint point = [touch locationInView:self];
    NSLog(@"【%@】%f, %f", tag, point.x, point.y);
}
@end
