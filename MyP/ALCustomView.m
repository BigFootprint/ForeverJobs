//
//  ALCustomView.m
//  MyP
//
//  Created by 李全民 on 17/2/22.
//  Copyright © 2017年 李全民. All rights reserved.
//

#import "ALCustomView.h"
#import "Masonry.h"

@interface ALCustomView()
@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGSize buttonSize;
@end

@implementation ALCustomView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"Grow Me!" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    
    [self.growingButton addTarget:self action:@selector(didTapGrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.growingButton];
    
    self.buttonSize = CGSizeMake(100, 100);
    
    return self;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    NSLog(@"XXXX: %@", NSStringFromCGRect(self.growingButton.frame));
    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(self.buttonSize.width)).priorityLow();
        make.height.equalTo(@(self.buttonSize.height)).priorityLow();
        make.width.lessThanOrEqualTo(self);
        make.height.lessThanOrEqualTo(self);
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
    NSLog(@"YYYY: %@", NSStringFromCGRect(self.growingButton.frame));
}

- (void)didTapGrowButton:(UIButton *)button {
    NSLog(@"AAAA");
    self.buttonSize = CGSizeMake(self.buttonSize.width * 1.3, self.buttonSize.height * 1.3);
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    NSLog(@"BBBB: %@", NSStringFromCGRect(self.growingButton.frame));
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    NSLog(@"CCCC: %@", NSStringFromCGRect(self.growingButton.frame));
    [UIView animateWithDuration:0.4 animations:^{
        NSLog(@"DDDD: %@", NSStringFromCGRect(self.growingButton.frame));
        [self layoutIfNeeded];
        NSLog(@"EEEE: %@", NSStringFromCGRect(self.growingButton.frame));
    }];
}

@end
